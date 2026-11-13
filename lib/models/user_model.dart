/// Modelo de datos básico del usuario de Bella Pasta & Pizza.
///
/// No incluye la contraseña: las credenciales no deben guardarse dentro del
/// modelo que se utiliza para transportar los datos del perfil.
class UserModel {
  final String name;
  final String email;
  final DateTime createdAt;

  UserModel({
    required this.name,
    required this.email,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Iniciales para mostrar en el avatar del perfil.
  String get initials {
    final words = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();

    if (words.isEmpty) return '?';
    if (words.length == 1) return words.first.substring(0, 1).toUpperCase();

    return '${words.first.substring(0, 1)}${words.last.substring(0, 1)}'
        .toUpperCase();
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      createdAt: DateTime.tryParse(map['createdAt'] as String? ?? ''),
    );
  }

  UserModel copyWith({String? name, String? email, DateTime? createdAt}) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
