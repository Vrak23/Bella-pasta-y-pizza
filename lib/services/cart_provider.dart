import 'package:flutter/foundation.dart';
import '../models/cart_item_model.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';

/// Provider de estado global para el Carrito de Compras de Bella Pasta & Pizza.
class CartProvider extends ChangeNotifier {
  final Map<String, CartItemModel> _items = {};

  bool _isDelivery = true;
  final double _deliveryFee = 5.00;
  String? _couponCode;
  double _discountPercentage = 0.0;
  bool _freeDeliveryCoupon = false;

  OrderModel? _lastOrder;

  // Getters
  Map<String, CartItemModel> get itemsMap => {..._items};
  List<CartItemModel> get items => _items.values.toList();
  bool get isDelivery => _isDelivery;
  String? get couponCode => _couponCode;
  OrderModel? get lastOrder => _lastOrder;

  int get itemCount =>
      _items.values.fold(0, (sum, item) => sum + item.quantity);

  bool get isEmpty => _items.isEmpty;

  double get subtotal =>
      _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get deliveryFee {
    if (isEmpty) return 0.0;
    if (!_isDelivery) return 0.0;
    if (_freeDeliveryCoupon) return 0.0;
    // Si la compra supera S/ 80, envío gratis automático
    if (subtotal >= 80.0) return 0.0;
    return _deliveryFee;
  }

  double get discountAmount {
    if (isEmpty || _discountPercentage <= 0) return 0.0;
    return subtotal * (_discountPercentage / 100.0);
  }

  double get total {
    if (isEmpty) return 0.0;
    final t = subtotal + deliveryFee - discountAmount;
    return t > 0 ? t : 0.0;
  }

  String get formattedSubtotal => 'S/ ${subtotal.toStringAsFixed(2)}';
  String get formattedDeliveryFee =>
      deliveryFee > 0 ? 'S/ ${deliveryFee.toStringAsFixed(2)}' : 'Gratis';
  String get formattedDiscountAmount =>
      'S/ ${discountAmount.toStringAsFixed(2)}';
  String get formattedTotal => 'S/ ${total.toStringAsFixed(2)}';

  /// Genera una clave única para identificar un ítem con sus personalizaciones.
  String _generateKey(
      String productId, String size, List<String> extras, String notes) {
    final sortedExtras = [...extras]..sort();
    return '${productId}_${size}_${sortedExtras.join("-")}_$notes';
  }

  /// Agrega un producto al carrito con personalizaciones.
  void addItem({
    required ProductModel product,
    String size = 'Personal',
    double sizeExtraPrice = 0.0,
    List<String> extras = const [],
    double extrasPrice = 0.0,
    String notes = '',
    int quantity = 1,
  }) {
    final key = _generateKey(product.id, size, extras, notes);

    if (_items.containsKey(key)) {
      _items[key]!.quantity += quantity;
    } else {
      _items[key] = CartItemModel(
        id: key,
        product: product,
        size: size,
        sizeExtraPrice: sizeExtraPrice,
        extras: extras,
        extrasPrice: extrasPrice,
        notes: notes,
        quantity: quantity,
      );
    }
    notifyListeners();
  }

  /// Incrementa en 1 la cantidad de un ítem.
  void increment(String cartItemId) {
    if (_items.containsKey(cartItemId)) {
      _items[cartItemId]!.quantity++;
      notifyListeners();
    }
  }

  /// Reduce en 1 la cantidad de un ítem. Si llega a 0, se elimina.
  void decrement(String cartItemId) {
    if (!_items.containsKey(cartItemId)) return;

    if (_items[cartItemId]!.quantity > 1) {
      _items[cartItemId]!.quantity--;
    } else {
      _items.remove(cartItemId);
    }
    notifyListeners();
  }

  /// Elimina un ítem específico del carrito.
  void removeItem(String cartItemId) {
    if (_items.remove(cartItemId) != null) {
      notifyListeners();
    }
  }

  /// Vacía todo el carrito.
  void clear() {
    _items.clear();
    _couponCode = null;
    _discountPercentage = 0.0;
    _freeDeliveryCoupon = false;
    notifyListeners();
  }

  /// Cambia el modo de entrega (Delivery / Recojo en tienda).
  void setDeliveryMode(bool isDelivery) {
    _isDelivery = isDelivery;
    notifyListeners();
  }

  /// Aplica un cupón promocional.
  bool applyCoupon(String code) {
    final cleanCode = code.trim().toUpperCase();
    if (cleanCode == 'BELLA10') {
      _couponCode = 'BELLA10 (10% OFF)';
      _discountPercentage = 10.0;
      _freeDeliveryCoupon = false;
      notifyListeners();
      return true;
    } else if (cleanCode == 'SENATI15' || cleanCode == 'SENATI') {
      _couponCode = 'SENATI (15% OFF)';
      _discountPercentage = 15.0;
      _freeDeliveryCoupon = false;
      notifyListeners();
      return true;
    } else if (cleanCode == 'ENVIOGRATIS' || cleanCode == 'DELIVERY') {
      _couponCode = 'ENVÍO GRATIS';
      _discountPercentage = 0.0;
      _freeDeliveryCoupon = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Quita el cupón aplicado.
  void removeCoupon() {
    _couponCode = null;
    _discountPercentage = 0.0;
    _freeDeliveryCoupon = false;
    notifyListeners();
  }

  /// Confirma y crea la orden de compra completa, guardando el detalle y vaciando el carrito.
  OrderModel checkout({
    required String customerName,
    required String customerPhone,
    required String deliveryAddress,
    String referenceAddress = '',
    required String paymentMethod,
    String orderNotes = '',
  }) {
    final orderNumber = (DateTime.now().millisecondsSinceEpoch % 90000) + 10000;
    final order = OrderModel(
      orderId: 'BP-$orderNumber',
      items: items.map((e) => e.copyWith()).toList(),
      createdAt: DateTime.now(),
      customerName: customerName.isNotEmpty ? customerName : 'Cliente Invitado',
      customerPhone: customerPhone.isNotEmpty ? customerPhone : '987 654 321',
      deliveryAddress: _isDelivery
          ? (deliveryAddress.isNotEmpty
              ? deliveryAddress
              : 'Av. Alfredo Mendiola 3520, Los Olivos')
          : 'Recojo en local principal (Av. La Marina 1845)',
      referenceAddress: referenceAddress,
      paymentMethod: paymentMethod,
      isDelivery: _isDelivery,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      discount: discountAmount,
      discountCode: _couponCode,
      total: total,
      notes: orderNotes,
      estimatedTime: _isDelivery ? '30 - 45 minutos' : '15 - 20 minutos',
      status: 'Confirmado y en cocina',
    );

    _lastOrder = order;
    clear();
    return order;
  }
}
