/// Modelo de datos para los productos de Bella Pasta & Pizza.
/// Administra los detalles de pizzas, pastas, bebidas y postres con precios en Soles (S/.).
class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String categoryId;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final bool isPopular;
  final List<String> ingredients;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    this.imageUrl = '',
    this.rating = 4.8,
    this.reviewsCount = 24,
    this.isPopular = false,
    this.ingredients = const [],
  });

  /// Precio formateado con símbolo de moneda peruana (Soles).
  String get formattedPrice => 'S/ ${price.toStringAsFixed(2)}';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category_id': categoryId,
      'image_url': imageUrl,
      'rating': rating,
      'reviews_count': reviewsCount,
      'is_popular': isPopular ? 1 : 0,
      'ingredients': ingredients.join(', '),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    final rawIngredients = map['ingredients'];
    List<String> parsedIngredients = [];
    if (rawIngredients is String && rawIngredients.isNotEmpty) {
      parsedIngredients = rawIngredients.split(',').map((e) => e.trim()).toList();
    } else if (rawIngredients is List) {
      parsedIngredients = rawIngredients.map((e) => e.toString()).toList();
    }

    return ProductModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      description: map['description'] as String? ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      categoryId: map['category_id'] as String? ?? 'pizzas',
      imageUrl: map['image_url'] as String? ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 4.5,
      reviewsCount: (map['reviews_count'] as num?)?.toInt() ?? 0,
      isPopular: map['is_popular'] == 1 || map['is_popular'] == true,
      ingredients: parsedIngredients,
    );
  }

  /// Catálogo de demostración oficial con recetas italianas tradicionales e imágenes locales.
  static const List<ProductModel> sampleProducts = [
    // --- PIZZAS ---
    ProductModel(
      id: 'pizza_margherita',
      name: 'Pizza Margherita Clásica',
      description:
          'Salsa pomodoro San Marzano, mozzarella fior di latte fresca, hojas de albahaca y aceite de oliva virgen extra.',
      price: 36.00,
      categoryId: 'pizzas',
      imageUrl: 'assets/images/pizza_margherita.jpg',
      rating: 4.9,
      reviewsCount: 112,
      isPopular: true,
      ingredients: ['Salsa Pomodoro', 'Mozzarella Fior di Latte', 'Albahaca Fresca', 'Aceite de Oliva'],
    ),
    ProductModel(
      id: 'pizza_pepperoni',
      name: 'Pizza Pepperoni Supremo',
      description:
          'Abundante pepperoni importado crocante al horno de leña, doble mozzarella derretida y toque de orégano silvestre.',
      price: 42.00,
      categoryId: 'pizzas',
      imageUrl: 'assets/images/pizza_pepperoni.jpg',
      rating: 4.8,
      reviewsCount: 95,
      isPopular: true,
      ingredients: ['Mozzarella Fundida', 'Pepperoni Picante', 'Salsa de Tomate', 'Orégano'],
    ),
    ProductModel(
      id: 'pizza_quattro_formaggi',
      name: 'Pizza Cuatro Quesos',
      description:
          'Fusión equilibrada de cuatro quesos selectos: mozzarella, gorgonzola italiano, queso provolone y parmesano reggiano.',
      price: 45.00,
      categoryId: 'pizzas',
      imageUrl: 'assets/images/pizza_quattro_formaggi.jpg',
      rating: 4.7,
      reviewsCount: 68,
      isPopular: false,
      ingredients: ['Mozzarella', 'Gorgonzola', 'Provolone', 'Parmesano Reggiano'],
    ),
    ProductModel(
      id: 'pizza_prosciutto_funghi',
      name: 'Pizza Prosciutto e Funghi',
      description:
          'Finas láminas de jamón serrano prosciutto crudo, champiñones frescos salteados al romero y base mozzarella.',
      price: 46.00,
      categoryId: 'pizzas',
      imageUrl: 'assets/images/pizza_prosciutto.jpg',
      rating: 4.8,
      reviewsCount: 54,
      isPopular: false,
      ingredients: ['Prosciutto Crudo', 'Champiñones Frescos', 'Mozzarella', 'Romero'],
    ),

    // --- PASTAS ---
    ProductModel(
      id: 'pasta_fettuccine_alfredo',
      name: 'Fettuccine Alfredo con Pollo',
      description:
          'Pasta fresca larga artesanal en suave salsa blanca cremosa al queso parmesano, acompañada de pechuga a las finas hierbas.',
      price: 34.00,
      categoryId: 'pastas',
      imageUrl: 'assets/images/pasta_fettuccine.jpg',
      rating: 4.9,
      reviewsCount: 130,
      isPopular: true,
      ingredients: ['Fettuccine Fresco', 'Crema de Parmesano', 'Pechuga a la Parrilla', 'Perejil'],
    ),
    ProductModel(
      id: 'pasta_lasagna_bolognese',
      name: 'Lasagna Bolognese Tradicional',
      description:
          'Láminas horneadas en salsa ragù de carne lenta de res y cerdo, salsa bechamel sedosa y gratinado dorado de parmesano.',
      price: 38.00,
      categoryId: 'pastas',
      imageUrl: 'assets/images/pasta_lasagna.jpg',
      rating: 4.8,
      reviewsCount: 88,
      isPopular: true,
      ingredients: ['Pasta Lasagna', 'Ragù Bolognese', 'Salsa Bechamel', 'Queso Gratinado'],
    ),
    ProductModel(
      id: 'pasta_spaghetti_carbonara',
      name: 'Spaghetti Carbonara Auténtica',
      description:
          'Receta tradicional romana: panceta dorada crujiente, yema de huevo pasteurizada, queso pecorino y pimienta negra molida.',
      price: 35.00,
      categoryId: 'pastas',
      imageUrl: 'assets/images/pasta_carbonara.jpg',
      rating: 4.7,
      reviewsCount: 76,
      isPopular: false,
      ingredients: ['Spaghetti al Dente', 'Panceta Crujiente', 'Pecorino Romano', 'Pimienta Negra'],
    ),
    ProductModel(
      id: 'pasta_ravioles_ricotta',
      name: 'Ravioles Ricotta y Espinaca',
      description:
          'Ravioles caseros rellenos de queso ricotta cremoso y espinaca fresca, bañados en salsa pomodoro rústica y piñones.',
      price: 37.00,
      categoryId: 'pastas',
      imageUrl: 'assets/images/pasta_ravioles.jpg',
      rating: 4.6,
      reviewsCount: 42,
      isPopular: false,
      ingredients: ['Ravioles Caseros', 'Ricotta', 'Espinaca', 'Pomodoro Rústico'],
    ),

    // --- BEBIDAS ---
    ProductModel(
      id: 'bebida_chicha_morada',
      name: 'Chicha Morada Artesanal (1L)',
      description:
          'Bebida emblemática peruana hervida con maíz morado, piña golden, manzana, canela, clavo de olor y jugo de limón.',
      price: 12.00,
      categoryId: 'bebidas',
      imageUrl: 'assets/images/bebida_chicha.jpg',
      rating: 4.9,
      reviewsCount: 90,
      isPopular: true,
      ingredients: ['Maíz Morado', 'Piña Golden', 'Manzana', 'Canela y Limón'],
    ),
    ProductModel(
      id: 'bebida_limonada_albahaca',
      name: 'Limonada de Albahaca Frappé',
      description:
          'Zumo natural de limones criollos batido con hojas de albahaca fresca y hielo picado, balance perfecto y refrescante.',
      price: 10.00,
      categoryId: 'bebidas',
      imageUrl: 'assets/images/bebida_limonada.jpg',
      rating: 4.7,
      reviewsCount: 52,
      isPopular: false,
      ingredients: ['Limón Criollo', 'Albahaca Fresca', 'Jarabe Simple', 'Hielo Frappé'],
    ),
    ProductModel(
      id: 'bebida_san_pellegrino',
      name: 'San Pellegrino Aranciata (330ml)',
      description:
          'Agua mineral con gas italiana elaborada con auténtico zumo de naranjas de Sicilia, burbujas finas y refrescantes.',
      price: 14.00,
      categoryId: 'bebidas',
      imageUrl: 'assets/images/bebida_san_pellegrino.jpg',
      rating: 4.6,
      reviewsCount: 38,
      isPopular: false,
      ingredients: ['Agua Mineralizada con Gas', 'Zumo de Naranja Italiana', 'Azúcar de Caña'],
    ),
    ProductModel(
      id: 'bebida_vino_chianti',
      name: 'Copa de Vino Tinto Chianti DOCG',
      description:
          'Vino clásico de la Toscana italiana, con notas frutales a cereza silvestre y taninos elegantes. Excelente maridaje con pastas.',
      price: 22.00,
      categoryId: 'bebidas',
      imageUrl: 'assets/images/bebida_vino.jpg',
      rating: 4.8,
      reviewsCount: 46,
      isPopular: false,
      ingredients: ['Uva Sangiovese (Toscana, Italia)', '13% Vol. Alc.'],
    ),

    // --- POSTRES ---
    ProductModel(
      id: 'postre_tiramisu',
      name: 'Tiramisú Tradicional Italiano',
      description:
          'Bizcochos savoiardi bañados en espresso concentrado y licor de café, capas de suave crema mascarpone y cacao amargo.',
      price: 18.00,
      categoryId: 'postres',
      imageUrl: 'assets/images/postre_tiramisu.jpg',
      rating: 5.0,
      reviewsCount: 140,
      isPopular: true,
      ingredients: ['Queso Mascarpone', 'Bizcochos Savoiardi', 'Espresso Italiano', 'Cacao Puro'],
    ),
    ProductModel(
      id: 'postre_panna_cotta',
      name: 'Panna Cotta con Frutos Rojos',
      description:
          'Postre piamontés de crema de leche aromatizada con vaina de vainilla de Madagascar y coulis artesanal de frambuesas.',
      price: 16.00,
      categoryId: 'postres',
      imageUrl: 'assets/images/postre_panna_cotta.jpg',
      rating: 4.7,
      reviewsCount: 59,
      isPopular: false,
      ingredients: ['Crema de Leche', 'Vainilla Natural', 'Coulis de Frambuesas y Fresas'],
    ),
  ];
}
