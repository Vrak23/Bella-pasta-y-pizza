# 🍕 Bella Pasta & Pizza (SENATI)
> **Escuela de Tecnologías de la Información • Aplicaciones Móviles**  
> Proyecto integrador desarrollado en **Flutter** para pedidos y personalización de gastronomía italiana tradicional.

---

## 🎯 Objetivo del Proyecto
Desarrollar una aplicación móvil interactiva para pedir y personalizar pizzas y pastas en Flutter, implementando arquitectura de widgets, control de estado reactivo y persistencia de datos local (SQLite) para optimizar la experiencia de usuario (UX).

* **Público Objetivo:** Personas de 15 a 45 años, amantes de la comida italiana, que buscan una interfaz intuitiva, rápida y fluida para personalizar sus pedidos desde el móvil.

---

## 👥 Reparto de Desarrollo (Equipo de 6 Integrantes)

| # | Integrante | Pantalla Asignada | Responsabilidad Técnica Transversal | Archivo Principal |
|---|:---|:---|:---|:---|
| 1 | **Rodrigo Llanos (Completado)** | **1. Splash / Bienvenida** | **Estilos Globales, Tema y Assets:** Paleta de colores italiana, `AppTheme`, tipografías Google Fonts, logotipo responsive y rutas centrales. | [`lib/screens/splash_screen.dart`](lib/screens/splash_screen.dart) |
| 2 | **Jerald (Completado)** | **2. Registro y Login** | **Modelos y Formularios:** Validación de campos (Email, Password), controladores de texto y modelo `UserModel`. | [`lib/screens/login_screen.dart`](lib/screens/login_screen.dart) |
| 3 | **Andre Zapata (Completado)** | **3. Menú de Categorías** | **Estructura y Widgets:** Cards de productos (`ProductCard`), filtros (`CategoryChip`), modelos (`ProductModel`, `CategoryModel`), buscador y barra de navegación inferior con precios en Soles (S/.). | [`lib/screens/menu_screen.dart`](lib/screens/menu_screen.dart) |
| 4 | **James (Completado)** | **4. Detalle y Personalización** | **Estado Dinámico (`setState`):** Selector de tamaño, checkboxes para ingredientes extra y cálculo reactivo de subtotal y total. | [`lib/screens/product_detail_screen.dart`](lib/screens/product_detail_screen.dart) |
| 5 | **James (Completado)** | **5. Mi Carrito de Compras** | **Gestor de Estado Global (`Provider`):** `CartProvider` para agregar/quitar ítems, manejo de cantidades (+ / -) y cálculo final. | [`lib/screens/cart_screen.dart`](lib/screens/cart_screen.dart) |
| 6 | **Completado** | **6. Confirmación y SQLite** | **Persistencia SQLite (`sqflite`):** `DatabaseHelper` (`lib/services/database_helper.dart`) para registrar la orden en la tabla local `pedido_pizza` e historial persistente (`OrderHistoryScreen`). | [`lib/screens/order_success_screen.dart`](lib/screens/order_success_screen.dart) |


### Implementación del Integrante 3: Menú de Categorías (Rama `Andre`)

La pantalla `lib/screens/menu_screen.dart` implementa de manera completa y modular el catálogo de productos gastronómicos tradicionales italianos:
- **Modelos de datos (`lib/models/`):**
  - `category_model.dart`: representación de las categorías (Todas, Pizzas, Pastas, Bebidas, Postres) con soporte de iconos y serialización.
  - `product_model.dart`: catálogo con recetas tradicionales (Margherita, Pepperoni Supremo, Cuatro Quesos, Fettuccine Alfredo, Lasagna Bolognese, Spaghetti Carbonara, Chicha Morada, Tiramisú, etc.), ratings, ingredientes, estado de popularidad y precios en moneda nacional Soles (`formattedPrice` => `S/ XX.XX`).
- **Componentes reutilizables (`lib/widgets/`):**
  - `category_chip.dart`: widget de selección animado para alternar filtros entre categorías.
  - `product_card.dart`: tarjeta gastronómica con imagen, badges flotantes (Popular/Rating), descripción, precio en Soles y botón de agregar o personalizar (`+`).
- **Navegación e Interacción:**
  - Buscador reactivo en tiempo real por título de producto, descripción e ingredientes.
  - `BottomNavigationBar` estilizado con 4 accesos rápidos (Menú, Personalizar, Carrito y Mi Perfil).
  - Integración con el argumento de usuario (`UserModel`) proveniente del Login para saludar al cliente de forma personalizada.
  - Panel BottomSheet con la información del alumno y opción para cerrar sesión.
  - Pruebas unitarias automatizadas en `test/menu_test.dart`.

### Implementación del Integrante 2: Registro y Login

La pantalla `lib/screens/login_screen.dart` permite alternar entre inicio de sesión y creación de cuenta. Incluye validación del nombre, formato del correo, longitud mínima de contraseña y coincidencia de confirmación; también permite mostrar u ocultar las contraseñas y utiliza el tema global y el avatar de perfil.

El modelo `lib/models/user_model.dart` representa el perfil con nombre, correo y fecha de creación, además de métodos para convertirlo a mapa y obtener sus iniciales. La contraseña no forma parte del modelo.

**Alcance de esta entrega:** el formulario y la navegación funcionan como demostración local y envían el `UserModel` a la ruta del menú. No hay autenticación real ni almacenamiento de cuentas; para producción habría que conectar un backend o proveedor de identidad.

---

## 📱 Flujo de las 6 Pantallas del Reto
1. **Splash / Bienvenida:** Cabecera con degradado rojo italiano, logotipo animado (`Hero`, `FadeTransition`, `ScaleTransition`), carrusel de destacados y botón *Comenzar Pedido*.
2. **Registro y Login:** Formulario de inicio de sesión con avatar circular y validación.
3. **Menú de Categorías:** Catálogo con precios en Soles (S/.) y filtro por tipo de producto.
4. **Detalle y Personalización:** Selección de ingredientes extras y cálculo de precio en tiempo real.
5. **Mi Carrito:** Resumen interactivo de la orden y gestión de cantidades.
6. **Confirmación de Pedido:** Animación de éxito e inserción en base de datos SQLite.

---

## 🏗️ Arquitectura de Carpetas (`lib/`)

```text
lib/
├── main.dart                  # Punto de entrada de la app
├── models/                    # Modelos de datos (Product, User, Category)
│   ├── category_model.dart    # Modelo de categorías gastronómicas
│   ├── product_model.dart     # Modelo de productos y catálogo en Soles (S/.)
│   └── user_model.dart        # Modelo de perfil del usuario
├── screens/                   # Las 6 pantallas del reto
│   ├── splash_screen.dart     # Pantalla 1 (Completada)
│   ├── login_screen.dart      # Pantalla 2 (registro, login y validaciones)
│   ├── menu_screen.dart       # Pantalla 3 (Completada por Integrante 3)
│   ├── product_detail_screen.dart # Pantalla 4
│   ├── cart_screen.dart       # Pantalla 5
│   └── order_success_screen.dart  # Pantalla 6
├── services/                  # Base de datos (SQLite) y Providers
├── utils/                     # Temas, constantes y rutas
│   ├── app_colors.dart        # Paleta italiana oficial
│   ├── app_routes.dart        # Mapeo de rutas con nombre
│   └── app_theme.dart         # Tema Material 3 + Google Fonts
└── widgets/                   # Widgets reutilizables
    ├── app_logo.dart          # Logotipo insignia con bandera italiana
    ├── category_chip.dart     # Chip de filtro interactivo por categoría
    └── product_card.dart      # Tarjeta visual con precio en Soles y acciones
```

---

## 📊 Matriz de Evaluación (SENATI)
| Criterio | Puntaje | Detalle |
|---|:---:|---|
| **Estructura Visual** | 5 / 5 | Uso óptimo de `Rows`, `Columns`, `Cards` y `Containers`. |
| **Dinámicos y Estado** | 4 / 5 | Implementación eficaz de `StatefulWidget` con `setState()`. |
| **Rendimiento y Recursos**| 5 / 5 | Gestión de dependencias y assets en `assets/images` y `assets/icons`. |
| **Datos y BD (SQLite)** | 4 / 5 | Operaciones CRUD rápidas y persistentes en el dispositivo. |
