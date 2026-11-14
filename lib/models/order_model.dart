import 'dart:convert';
import 'cart_item_model.dart';

/// Modelo de orden / pedido con todos los detalles de la compra.
class OrderModel {
  final String orderId;
  final List<CartItemModel> items;
  final DateTime createdAt;
  final String customerName;
  final String customerPhone;
  final String deliveryAddress;
  final String referenceAddress;
  final String paymentMethod;
  final bool isDelivery;
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final String? discountCode;
  final double total;
  final String notes;
  final String estimatedTime;
  final String status;

  OrderModel({
    required this.orderId,
    required this.items,
    required this.createdAt,
    required this.customerName,
    required this.customerPhone,
    required this.deliveryAddress,
    this.referenceAddress = '',
    required this.paymentMethod,
    this.isDelivery = true,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    this.discountCode,
    required this.total,
    this.notes = '',
    this.estimatedTime = '30 - 45 minutos',
    this.status = 'En preparación',
  });

  String get formattedSubtotal => 'S/ ${subtotal.toStringAsFixed(2)}';
  String get formattedDeliveryFee =>
      deliveryFee > 0 ? 'S/ ${deliveryFee.toStringAsFixed(2)}' : 'Gratis';
  String get formattedDiscount => 'S/ ${discount.toStringAsFixed(2)}';
  String get formattedTotal => 'S/ ${total.toStringAsFixed(2)}';

  int get totalItemsCount =>
      items.fold(0, (count, item) => count + item.quantity);

  /// Resumen legible de productos para la columna `pizza` de SQLite.
  String get summaryProducts => items
      .map((i) => '${i.quantity}x ${i.product.name} (${i.size})')
      .join(', ');

  /// Resumen legible de ingredientes/extras para la columna `ingredientes` de SQLite.
  String get summaryIngredients {
    final allExtras = items.expand((i) => i.extras).toSet().toList();
    return allExtras.isEmpty ? 'Estándar' : allExtras.join(', ');
  }

  /// Convierte el pedido a un mapa compatible con la tabla SQLite `pedido_pizza`.
  Map<String, dynamic> toDbMap() {
    return {
      'order_id': orderId,
      'pizza': summaryProducts,
      'ingredientes': summaryIngredients,
      'cantidad': totalItemsCount,
      'total': total,
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'delivery_address': deliveryAddress,
      'reference_address': referenceAddress,
      'payment_method': paymentMethod,
      'is_delivery': isDelivery ? 1 : 0,
      'subtotal': subtotal,
      'delivery_fee': deliveryFee,
      'discount': discount,
      'discount_code': discountCode,
      'notes': notes,
      'estimated_time': estimatedTime,
      'status': status,
      'items_json': jsonEncode(items.map((e) => e.toMap()).toList()),
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Reconstruye un `OrderModel` desde una fila de SQLite.
  factory OrderModel.fromDbMap(Map<String, dynamic> map) {
    List<CartItemModel> parsedItems = [];
    final rawJson = map['items_json'] as String?;
    if (rawJson != null && rawJson.isNotEmpty) {
      final decoded = jsonDecode(rawJson) as List<dynamic>;
      parsedItems = decoded
          .map((e) => CartItemModel.fromMap(e as Map<String, dynamic>))
          .toList();
    }

    return OrderModel(
      orderId: map['order_id'] as String? ?? 'BP-00000',
      items: parsedItems,
      createdAt: DateTime.tryParse(map['created_at'] as String? ?? '') ??
          DateTime.now(),
      customerName: map['customer_name'] as String? ?? 'Cliente SENATI',
      customerPhone: map['customer_phone'] as String? ?? '',
      deliveryAddress: map['delivery_address'] as String? ?? '',
      referenceAddress: map['reference_address'] as String? ?? '',
      paymentMethod: map['payment_method'] as String? ?? 'Efectivo',
      isDelivery: (map['is_delivery'] as int? ?? 1) == 1,
      subtotal: (map['subtotal'] as num?)?.toDouble() ?? 0.0,
      deliveryFee: (map['delivery_fee'] as num?)?.toDouble() ?? 0.0,
      discount: (map['discount'] as num?)?.toDouble() ?? 0.0,
      discountCode: map['discount_code'] as String?,
      total: (map['total'] as num?)?.toDouble() ?? 0.0,
      notes: map['notes'] as String? ?? '',
      estimatedTime: map['estimated_time'] as String? ?? '30 - 45 minutos',
      status: map['status'] as String? ?? 'En preparación',
    );
  }
}

