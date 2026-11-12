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
| 1 | **Tú (Completado)** | **1. Splash / Bienvenida** | **Estilos Globales, Tema y Assets:** Paleta de colores italiana, `AppTheme`, tipografías Google Fonts, logotipo responsive y rutas centrales. | [`lib/screens/splash_screen.dart`](lib/screens/splash_screen.dart) |
| 2 | Integrante 2 | **2. Registro y Login** | **Modelos y Formularios:** Validación de campos (Email, Password), controladores de texto y modelo `UserModel`. | [`lib/screens/login_screen.dart`](lib/screens/login_screen.dart) |
| 3 | Integrante 3 | **3. Menú de Categorías** | **Estructura y Widgets:** Cards de productos (`ProductCard`), categorías (Pizzas, Pastas, Bebidas) y barra de navegación inferior. | [`lib/screens/menu_screen.dart`](lib/screens/menu_screen.dart) |
| 4 | Integrante 4 | **4. Detalle y Personalización** | **Estado Dinámico (`setState`):** Selector de tamaño, checkboxes para ingredientes extra y cálculo reactivo de subtotal y total. | [`lib/screens/product_detail_screen.dart`](lib/screens/product_detail_screen.dart) |
| 5 | Integrante 5 | **5. Mi Carrito de Compras** | **Gestor de Estado Global (`Provider`):** `CartProvider` para agregar/quitar ítems, manejo de cantidades (+ / -) y cálculo final. | [`lib/screens/cart_screen.dart`](lib/screens/cart_screen.dart) |
| 6 | Integrante 6 | **6. Confirmación de Pedido** | **Persistencia SQLite (`sqflite`):** `DatabaseHelper` para registrar la orden en la tabla local `pedidos` y visualización de éxito. | [`lib/screens/order_success_screen.dart`](lib/screens/order_success_screen.dart) |

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
├── models/                    # Modelos de datos (Product, User, CartItem, Order)
├── screens/                   # Las 6 pantallas del reto
│   ├── splash_screen.dart     # Pantalla 1 (Completada)
│   ├── login_screen.dart      # Pantalla 2
│   ├── menu_screen.dart       # Pantalla 3
│   ├── product_detail_screen.dart # Pantalla 4
│   ├── cart_screen.dart       # Pantalla 5
│   └── order_success_screen.dart  # Pantalla 6
├── services/                  # Base de datos (SQLite) y Providers
├── utils/                     # Temas, constantes y rutas
│   ├── app_colors.dart        # Paleta italiana oficial
│   ├── app_routes.dart        # Mapeo de rutas con nombre
│   └── app_theme.dart         # Tema Material 3 + Google Fonts
└── widgets/                   # Widgets reutilizables
    └── app_logo.dart          # Logotipo insignia con bandera italiana
```

---

## 📊 Matriz de Evaluación (SENATI)
| Criterio | Puntaje | Detalle |
|---|:---:|---|
| **Estructura Visual** | 5 / 5 | Uso óptimo de `Rows`, `Columns`, `Cards` y `Containers`. |
| **Dinámicos y Estado** | 4 / 5 | Implementación eficaz de `StatefulWidget` con `setState()`. |
| **Rendimiento y Recursos**| 5 / 5 | Gestión de dependencias y assets en `assets/images` y `assets/icons`. |
| **Datos y BD (SQLite)** | 4 / 5 | Operaciones CRUD rápidas y persistentes en el dispositivo. |
