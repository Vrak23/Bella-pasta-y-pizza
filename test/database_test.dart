import 'package:flutter_test/flutter_test.dart';
import 'package:bella_pasta_pizza/models/cart_item_model.dart';
import 'package:bella_pasta_pizza/models/order_model.dart';
import 'package:bella_pasta_pizza/models/product_model.dart';

void main() {
  group('Pruebas de Serialización SQLite - OrderModel', () {
    test('OrderModel se serializa y deserializa correctamente para SQLite', () {
      final product = ProductModel.sampleProducts.first;
      final item = CartItemModel(
        id: 'test_1',
        product: product,
        size: 'Mediana',
        sizeExtraPrice: 8.0,
        extras: ['Queso Mozzarella Extra', 'Albahaca'],
        extrasPrice: 6.5,
        notes: 'Sin cebolla',
        quantity: 2,
      );

      final order = OrderModel(
        orderId: 'BP-12345',
        items: [item],
        createdAt: DateTime(2026, 11, 14, 10, 30),
        customerName: 'Rodrigo Llanos',
        customerPhone: '999 888 777',
        deliveryAddress: 'Av. Alfredo Mendiola 3520',
        referenceAddress: 'Campus SENATI',
        paymentMethod: 'Yape / Plin',
        isDelivery: true,
        subtotal: 101.0,
        deliveryFee: 0.0,
        discount: 10.1,
        discountCode: 'BELLA10',
        total: 90.9,
        notes: 'Tocar timbre',
      );

      final dbMap = order.toDbMap();
      expect(dbMap['order_id'], equals('BP-12345'));
      expect(dbMap['cantidad'], equals(2));
      expect(dbMap['total'], equals(90.9));
      expect(dbMap['pizza'], contains(product.name));
      expect(dbMap['ingredientes'], contains('Queso Mozzarella Extra'));

      final restored = OrderModel.fromDbMap(dbMap);
      expect(restored.orderId, equals(order.orderId));
      expect(restored.customerName, equals(order.customerName));
      expect(restored.items.length, equals(1));
      expect(restored.items.first.product.name, equals(product.name));
      expect(restored.items.first.extras.length, equals(2));
      expect(restored.total, equals(90.9));
    });
  });
}
