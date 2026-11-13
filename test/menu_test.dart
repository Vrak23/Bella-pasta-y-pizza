import 'package:flutter_test/flutter_test.dart';
import 'package:bella_pasta_pizza/models/category_model.dart';
import 'package:bella_pasta_pizza/models/product_model.dart';

void main() {
  group('Pruebas Unitarias - Integrante 3: Menú y Categorías', () {
    test('Verificar categorías predeterminadas del menú', () {
      final categories = CategoryModel.defaultCategories;
      expect(categories.isNotEmpty, isTrue);
      expect(categories.any((c) => c.id == 'todas'), isTrue);
      expect(categories.any((c) => c.id == 'pizzas'), isTrue);
      expect(categories.any((c) => c.id == 'pastas'), isTrue);
      expect(categories.any((c) => c.id == 'bebidas'), isTrue);
      expect(categories.any((c) => c.id == 'postres'), isTrue);
    });

    test('Verificar formato de moneda en Soles (S/.) para productos', () {
      const product = ProductModel(
        id: 'test_pizza',
        name: 'Pizza Prueba',
        description: 'Descripción de prueba',
        price: 36.50,
        categoryId: 'pizzas',
      );

      expect(product.formattedPrice, equals('S/ 36.50'));
    });

    test('Verificar serialización y deserialización de ProductModel', () {
      const product = ProductModel(
        id: 'test_pasta',
        name: 'Pasta Carbonara',
        description: 'Pasta con panceta y queso',
        price: 32.00,
        categoryId: 'pastas',
        isPopular: true,
        ingredients: ['Panceta', 'Pecorino', 'Huevo'],
      );

      final map = product.toMap();
      expect(map['id'], equals('test_pasta'));
      expect(map['price'], equals(32.00));
      expect(map['is_popular'], equals(1));

      final fromMap = ProductModel.fromMap(map);
      expect(fromMap.id, equals(product.id));
      expect(fromMap.name, equals(product.name));
      expect(fromMap.price, equals(product.price));
      expect(fromMap.isPopular, isTrue);
    });
  });
}
