import 'product_model.dart';

/// Representa un elemento dentro del carrito de compras.
/// Incluye personalización de tamaño, ingredientes extras, notas y cantidad.
class CartItemModel {
  final String id;
  final ProductModel product;
  final String size;
  final double sizeExtraPrice;
  final List<String> extras;
  final double extrasPrice;
  final String notes;
  int quantity;

  CartItemModel({
    required this.id,
    required this.product,
    this.size = 'Personal',
    this.sizeExtraPrice = 0.0,
    this.extras = const [],
    this.extrasPrice = 0.0,
    this.notes = '',
    this.quantity = 1,
  });

  /// Precio unitario sumando producto base + variación de tamaño + extras.
  double get unitPrice => product.price + sizeExtraPrice + extrasPrice;

  /// Precio total para la cantidad indicada.
  double get totalPrice => unitPrice * quantity;

  /// Precio unitario formateado en Soles.
  String get formattedUnitPrice => 'S/ ${unitPrice.toStringAsFixed(2)}';

  /// Precio total formateado en Soles.
  String get formattedTotalPrice => 'S/ ${totalPrice.toStringAsFixed(2)}';

  CartItemModel copyWith({
    String? id,
    ProductModel? product,
    String? size,
    double? sizeExtraPrice,
    List<String>? extras,
    double? extrasPrice,
    String? notes,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      product: product ?? this.product,
      size: size ?? this.size,
      sizeExtraPrice: sizeExtraPrice ?? this.sizeExtraPrice,
      extras: extras ?? this.extras,
      extrasPrice: extrasPrice ?? this.extrasPrice,
      notes: notes ?? this.notes,
      quantity: quantity ?? this.quantity,
    );
  }
}
