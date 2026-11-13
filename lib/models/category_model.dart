import 'package:flutter/material.dart';

/// Modelo de datos para las categorías del menú en Bella Pasta & Pizza.
/// Representa secciones como Pizzas, Pastas, Bebidas y Postres.
class CategoryModel {
  final String id;
  final String name;
  final IconData icon;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  /// Lista predefinida de categorías disponibles en el restaurante.
  static const List<CategoryModel> defaultCategories = [
    CategoryModel(
      id: 'todas',
      name: 'Todas',
      icon: Icons.grid_view_rounded,
    ),
    CategoryModel(
      id: 'pizzas',
      name: 'Pizzas',
      icon: Icons.local_pizza_rounded,
    ),
    CategoryModel(
      id: 'pastas',
      name: 'Pastas',
      icon: Icons.dinner_dining_rounded,
    ),
    CategoryModel(
      id: 'bebidas',
      name: 'Bebidas',
      icon: Icons.local_drink_rounded,
    ),
    CategoryModel(
      id: 'postres',
      name: 'Postres',
      icon: Icons.cake_rounded,
    ),
  ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map, {IconData icon = Icons.category}) {
    return CategoryModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      icon: icon,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

