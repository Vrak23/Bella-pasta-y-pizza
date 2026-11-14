import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';
import '../services/cart_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';
import '../widgets/category_chip.dart';
import '../widgets/product_card.dart';

/// Pantalla 3: Menú de Categorías.
/// Asignada al Integrante 3.
///
/// Responsabilidades técnicas:
/// - Listado dinámico de categorías (Todas, Pizzas, Pastas, Bebidas, Postres).
/// - Grid de productos gastronómicos con Cards personalizadas.
/// - Precios expresados en moneda nacional (Soles - S/.).
/// - Buscador en tiempo real por nombre e ingredientes.
/// - Barra de navegación inferior (BottomNavigationBar) con estados activos.
/// - Recepción opcional del usuario registrado (UserModel).
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategoryId = 'todas';
  int _currentNavIndex = 0;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Filtra los productos según la categoría seleccionada y el texto de búsqueda.
  List<ProductModel> get _filteredProducts {
    return ProductModel.sampleProducts.where((product) {
      final matchesCategory = _selectedCategoryId == 'todas' ||
          product.categoryId == _selectedCategoryId;

      final query = _searchQuery.trim().toLowerCase();
      if (query.isEmpty) {
        return matchesCategory;
      }

      final matchesName = product.name.toLowerCase().contains(query);
      final matchesDescription =
          product.description.toLowerCase().contains(query);
      final matchesIngredients =
          product.ingredients.any((ing) => ing.toLowerCase().contains(query));

      return matchesCategory &&
          (matchesName || matchesDescription || matchesIngredients);
    }).toList();
  }

  void _onCategorySelected(String categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
    });
  }

  void _onNavigationTapped(int index) {
    setState(() {
      _currentNavIndex = index;
    });

    switch (index) {
      case 0:
        // Ya estamos en Menú
        break;
      case 1:
        // Navegar a Detalle y Personalización
        Navigator.pushNamed(context, AppRoutes.productDetail);
        break;
      case 2:
        // Navegar al Carrito de Compras
        Navigator.pushNamed(context, AppRoutes.cart);
        break;
      case 3:
        // Abrir panel modal de perfil de usuario
        _showUserProfileModal();
        break;
    }
  }

  void _showUserProfileModal() {
    final user = ModalRoute.of(context)?.settings.arguments as UserModel?;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 36,
                backgroundColor: AppColors.primary,
                child: Text(
                  user?.initials ?? 'AZ',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                user?.name ?? 'Andre Zapata',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                user?.email ?? 'andrebryamzapatavega@gmail.com',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.school_rounded, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SENATI - Aplicaciones Móviles',
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Integrante 3: Menú de Categorías',
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.receipt_long_rounded),
                  label: const Text('Mis Pedidos (SQLite)'),
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.pushNamed(context, AppRoutes.orderHistory);
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(
                    Icons.android_rounded,
                    color: AppColors.secondary,
                  ),
                  label: const Text(
                    'Descargar APK (Android)',
                    style: TextStyle(color: AppColors.secondary),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.secondary, width: 1.5),
                  ),
                  onPressed: () {
                    const apkUrl =
                        'https://github.com/Vrak23/Bella-pasta-y-pizza/releases/latest/download/bella-pasta-pizza.apk';
                    Navigator.pop(ctx);
                    showDialog(
                      context: context,
                      builder: (dCtx) => AlertDialog(
                        title: const Row(
                          children: [
                            Icon(Icons.android_rounded, color: AppColors.secondary),
                            SizedBox(width: 8),
                            Text('Descargar APK'),
                          ],
                        ),
                        content: const Text(
                          'Descarga el instalador oficial para Android directamente desde GitHub Releases:\n\n$apkUrl',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dCtx),
                            child: const Text('Cerrar'),
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.copy_rounded, size: 18),
                            label: const Text('Copiar enlace'),
                            onPressed: () {
                              Clipboard.setData(const ClipboardData(text: apkUrl));
                              Navigator.pop(dCtx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: AppColors.secondary,
                                  content: Text(
                                    'Enlace de descarga APK copiado al portapapeles.',
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Cerrar Sesión'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)?.settings.arguments as UserModel?;
    final products = _filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bella Pasta & Pizza',
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long_outlined),
            tooltip: 'Historial de Pedidos (SQLite)',
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.orderHistory),
          ),
          Consumer<CartProvider>(
            builder: (context, cart, _) => Badge(
              isLabelVisible: cart.itemCount > 0,
              label: Text('${cart.itemCount}'),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                tooltip: 'Ver Carrito',
                onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Banner de Bienvenida y Buscador
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.headerGradient,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '¡Benvenuto!',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            user != null
                                ? 'Hola, ${user.name.split(' ').first} ¿Qué te provoca hoy?'
                                : '¿Qué delicia italiana te provoca hoy?',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Container(
                                width: 8, height: 8, color: AppColors.italianGreen),
                            Container(
                                width: 8, height: 8, color: AppColors.italianWhite),
                            Container(
                                width: 8, height: 8, color: AppColors.italianRed),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Caja de Búsqueda
                  TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Buscar pizzas, pastas, postres o bebidas...',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.primary,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Selector horizontal de Categorías (CategoryChip)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      'Categorías',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 44,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      itemCount: CategoryModel.defaultCategories.length,
                      itemBuilder: (context, index) {
                        final category = CategoryModel.defaultCategories[index];
                        final isSelected = category.id == _selectedCategoryId;

                        return CategoryChip(
                          category: category,
                          isSelected: isSelected,
                          onTap: () => _onCategorySelected(category.id),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Resumen de Platillos Encontrados
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Especialidades Italianas',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${products.length} platillos',
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Grid de Productos o Estado Vacío
          if (products.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 64,
                        color: AppColors.textMuted.withValues(alpha: 0.7),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No se encontraron platillos',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Prueba con otra palabra o revisa otra categoría.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 18),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Restablecer Filtros'),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                            _selectedCategoryId = 'todas';
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 260,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.68,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = products[index];
                    return ProductCard(
                      product: product,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.productDetail,
                          arguments: product,
                        );
                      },
                      onAddToCart: () {
                        // Navega al detalle pasando el producto para personalizarlo
                        Navigator.pushNamed(
                          context,
                          AppRoutes.productDetail,
                          arguments: product,
                        );
                      },
                    );
                  },
                  childCount: products.length,
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          final cartCount = context.watch<CartProvider>().itemCount;
          return BottomNavigationBar(
            currentIndex: _currentNavIndex,
            onTap: _onNavigationTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textMuted,
            selectedLabelStyle: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            elevation: 10,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_menu_rounded),
                activeIcon: Icon(Icons.restaurant_menu_rounded),
                label: 'Menú',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.tune_rounded),
                label: 'Personalizar',
              ),
              BottomNavigationBarItem(
                icon: Badge(
                  isLabelVisible: cartCount > 0,
                  label: Text('$cartCount'),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
                activeIcon: Badge(
                  isLabelVisible: cartCount > 0,
                  label: Text('$cartCount'),
                  child: const Icon(Icons.shopping_cart_rounded),
                ),
                label: 'Carrito',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                activeIcon: Icon(Icons.person_rounded),
                label: 'Mi Perfil',
              ),
            ],
          );
        },
      ),
    );
  }
}
