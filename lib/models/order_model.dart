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
}
