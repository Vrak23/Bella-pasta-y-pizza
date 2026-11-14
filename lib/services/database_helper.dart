import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../models/order_model.dart';

/// Servicio de Base de Datos Local (SQLite) para Bella Pasta & Pizza (SENATI).
/// Administra la tabla `pedido_pizza` para persistir las órdenes realizadas
/// en el dispositivo móvil de forma rápida y confiable.
class DatabaseHelper {
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static const String _databaseName = 'bella_pasta_pizza.db';
  static const int _databaseVersion = 1;
  static const String tableOrders = 'pedido_pizza';

  Database? _database;

  // Fallback en memoria cuando se ejecuta en Flutter Web (donde sqflite nativo no opera)
  final List<OrderModel> _webMemoryOrders = [];

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableOrders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id TEXT UNIQUE NOT NULL,
        pizza TEXT NOT NULL,
        ingredientes TEXT NOT NULL,
        cantidad INTEGER NOT NULL,
        total REAL NOT NULL,
        customer_name TEXT NOT NULL,
        customer_phone TEXT NOT NULL,
        delivery_address TEXT NOT NULL,
        reference_address TEXT,
        payment_method TEXT NOT NULL,
        is_delivery INTEGER NOT NULL DEFAULT 1,
        subtotal REAL NOT NULL,
        delivery_fee REAL NOT NULL,
        discount REAL NOT NULL,
        discount_code TEXT,
        notes TEXT,
        estimated_time TEXT NOT NULL,
        status TEXT NOT NULL,
        items_json TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
  }

  /// Inserta una nueva orden en la base de datos SQLite.
  Future<int> insertOrder(OrderModel order) async {
    if (kIsWeb) {
      _webMemoryOrders.removeWhere((o) => o.orderId == order.orderId);
      _webMemoryOrders.insert(0, order);
      return _webMemoryOrders.length;
    }

    final db = await database;
    return db.insert(
      tableOrders,
      order.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtiene todos los pedidos guardados ordenados del más reciente al más antiguo.
  Future<List<OrderModel>> getOrders() async {
    if (kIsWeb) {
      return List<OrderModel>.from(_webMemoryOrders);
    }

    final db = await database;
    final maps = await db.query(
      tableOrders,
      orderBy: 'id DESC',
    );
    return maps.map((map) => OrderModel.fromDbMap(map)).toList();
  }

  /// Obtiene la cantidad total de pedidos almacenados.
  Future<int> getOrdersCount() async {
    if (kIsWeb) {
      return _webMemoryOrders.length;
    }

    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as total FROM $tableOrders');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Elimina un pedido específico por su `orderId`.
  Future<int> deleteOrder(String orderId) async {
    if (kIsWeb) {
      _webMemoryOrders.removeWhere((o) => o.orderId == orderId);
      return 1;
    }

    final db = await database;
    return db.delete(
      tableOrders,
      where: 'order_id = ?',
      whereArgs: [orderId],
    );
  }

  /// Limpia todo el historial de pedidos de la tabla.
  Future<int> clearOrders() async {
    if (kIsWeb) {
      _webMemoryOrders.clear();
      return 1;
    }

    final db = await database;
    return db.delete(tableOrders);
  }

  /// Cierra la conexión con la base de datos.
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
