import 'package:flutter_test/flutter_test.dart';
import 'package:bella_pasta_pizza/models/product_model.dart';
import 'package:bella_pasta_pizza/services/cart_provider.dart';

void main() {
  group('Pruebas Unitarias - Carrito y Detalles de Compra', () {
    late CartProvider cart;
    final testProduct = ProductModel.sampleProducts.first;

    setUp(() {
      cart = CartProvider();
    });

    test('El carrito inicia vacío', () {
      expect(cart.isEmpty, isTrue);
      expect(cart.itemCount, equals(0));
      expect(cart.total, equals(0.0));
    });

    test('Agregar producto al carrito calcula correctamente los precios', () {
      cart.addItem(
        product: testProduct,
        size: 'Mediana',
        sizeExtraPrice: 8.0,
        extras: ['Queso Mozzarella Extra'],
        extrasPrice: 4.5,
        notes: 'Bien cocida',
        quantity: 2,
      );

      expect(cart.isEmpty, isFalse);
      expect(cart.itemCount, equals(2));
      expect(cart.items.length, equals(1));

      // Precio unitario: 36.00 + 8.00 + 4.50 = 48.50
      // Subtotal (x2): 97.00
      expect(cart.items.first.unitPrice, equals(48.50));
      expect(cart.subtotal, equals(97.00));
    });

    test('Incrementar y decrementar cantidades', () {
      cart.addItem(product: testProduct, quantity: 1);
      final itemId = cart.items.first.id;

      cart.increment(itemId);
      expect(cart.itemCount, equals(2));

      cart.decrement(itemId);
      expect(cart.itemCount, equals(1));

      cart.decrement(itemId);
      expect(cart.isEmpty, isTrue);
    });

    test('Aplicar cupón de descuento BELLA10 (10% OFF)', () {
      cart.addItem(product: testProduct, quantity: 1); // 36.00
      final initialTotal = cart.subtotal;

      final applied = cart.applyCoupon('BELLA10');
      expect(applied, isTrue);
      expect(cart.discountAmount, equals(initialTotal * 0.10));
    });

    test('Checkout genera orden con detalles completos y vacía el carrito', () {
      cart.addItem(product: testProduct, quantity: 1);

      final order = cart.checkout(
        customerName: 'Andre Zapata',
        customerPhone: '987 654 321',
        deliveryAddress: 'Av. Alfredo Mendiola 3520, Los Olivos',
        paymentMethod: 'Yape / Plin',
      );

      expect(order.orderId.startsWith('BP-'), isTrue);
      expect(order.customerName, equals('Andre Zapata'));
      expect(order.items.length, equals(1));
      expect(order.items.first.product.name, equals(testProduct.name));
      expect(cart.isEmpty, isTrue);
      expect(cart.lastOrder, isNotNull);
    });
  });
}
