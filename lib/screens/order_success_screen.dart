import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/order_model.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';
import '../services/cart_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';

/// Pantalla 6: Confirmación de Pedido y Detalles de la Compra
/// Muestra el comprobante completo, seguimiento del pedido,
/// desglose financiero y datos de entrega/facturación.
class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routeOrder =
        ModalRoute.of(context)?.settings.arguments as OrderModel?;
    final lastOrder = context.read<CartProvider>().lastOrder;

    final order = routeOrder ??
        lastOrder ??
        OrderModel(
          orderId: 'BP-92841',
          items: [
            CartItemModel(
              id: 'demo_1',
              product: ProductModel.sampleProducts[0],
              size: 'Mediana',
              sizeExtraPrice: 8.0,
              extras: ['Queso Mozzarella Extra'],
              extrasPrice: 4.5,
              notes: 'Bien cocida',
              quantity: 1,
            ),
            CartItemModel(
              id: 'demo_2',
              product: ProductModel.sampleProducts[4],
              size: 'Personal',
              quantity: 2,
            ),
          ],
          createdAt: DateTime.now(),
          customerName: 'Andre Zapata',
          customerPhone: '987 654 321',
          deliveryAddress: 'Av. Alfredo Mendiola 3520, Los Olivos',
          referenceAddress: 'Campus SENATI, Piso 2',
          paymentMethod: 'Yape / Plin',
          isDelivery: true,
          subtotal: 116.50,
          deliveryFee: 0.0,
          discount: 11.65,
          discountCode: 'BELLA10 (10% OFF)',
          total: 104.85,
          notes: 'Timbrar al llegar',
          estimatedTime: '30 - 45 minutos',
          status: 'En cocina / horno de leña',
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles de la Compra',
          style: GoogleFonts.playfairDisplay(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.home_rounded),
            tooltip: 'Ir al inicio',
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.menu,
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 30),
        child: Column(
          children: [
            // Cabecera de Confirmación Exitosa
            Center(
              child: Column(
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      size: 60,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    '¡Pedido Confirmado con Éxito!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Orden: #${order.orderId}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'El chef ya tiene tu orden en el horno artesanal.',
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Card de Estado y Tiempo Estimado
            _buildOrderStatusCard(order),
            const SizedBox(height: 20),

            // Tarjeta de Detalles del Comprobante
            _buildOrderReceiptCard(order),
            const SizedBox(height: 20),

            // Datos de Entrega y Facturación
            _buildDeliveryAndPaymentCard(order),
            const SizedBox(height: 28),

            // Botones de acción
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: AppColors.primary, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.history_rounded, color: AppColors.primary),
                    label: Text(
                      'Ver Historial',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.orderHistory);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.restaurant_menu_rounded),
                    label: Text(
                      'Nuevo Pedido',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.menu,
                        (route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatusCard(OrderModel order) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.timer_outlined,
                        color: AppColors.primary, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'Tiempo estimado:',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    order.estimatedTime,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Stepper visual
            Row(
              children: [
                _buildStep(Icons.receipt_long_rounded, 'Recibido', true),
                _buildStepLine(true),
                _buildStep(Icons.local_fire_department_rounded, 'En Cocina', true),
                _buildStepLine(false),
                _buildStep(
                  order.isDelivery
                      ? Icons.delivery_dining_rounded
                      : Icons.store_rounded,
                  order.isDelivery ? 'En camino' : 'Listo',
                  false,
                ),
                _buildStepLine(false),
                _buildStep(Icons.task_alt_rounded, 'Entregado', false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(IconData icon, String label, bool active) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor:
              active ? AppColors.secondary : AppColors.background,
          child: Icon(
            icon,
            size: 16,
            color: active ? Colors.white : AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            color: active ? AppColors.textPrimary : AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(bool active) {
    return Expanded(
      child: Container(
        height: 3,
        color: active ? AppColors.secondary : AppColors.border,
        margin: const EdgeInsets.only(bottom: 14),
      ),
    );
  }

  Widget _buildOrderReceiptCard(OrderModel order) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Detalle de la Compra',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${order.items.length} productos',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const Divider(color: AppColors.border, height: 24),

            // Lista de platillos
            ...order.items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${item.quantity}x',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.product.name,
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Tamaño: ${item.size}',
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          if (item.extras.isNotEmpty)
                            Text(
                              '+ Extras: ${item.extras.join(", ")}',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: AppColors.textMuted,
                              ),
                            ),
                          if (item.notes.isNotEmpty)
                            Text(
                              'Nota: "${item.notes}"',
                              style: GoogleFonts.poppins(
                                fontSize: 10.5,
                                fontStyle: FontStyle.italic,
                                color: AppColors.textMuted,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      item.formattedTotalPrice,
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              );
            }),

            const Divider(color: AppColors.border, height: 20),

            // Desglose Financiero
            _buildPriceRow('Subtotal', order.formattedSubtotal),
            const SizedBox(height: 6),
            _buildPriceRow(
              'Envío (Delivery)',
              order.formattedDeliveryFee,
              highlightGreen: order.deliveryFee == 0,
            ),
            if (order.discount > 0) ...[
              const SizedBox(height: 6),
              _buildPriceRow(
                'Descuento (${order.discountCode ?? "Cupón"})',
                '- ${order.formattedDiscount}',
                highlightGreen: true,
              ),
            ],
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL CANCELADO',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    order.formattedTotal,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryAndPaymentCard(OrderModel order) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Datos de Entrega y Facturación',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 14),
            _buildInfoRow(
                Icons.person_rounded, 'Cliente', order.customerName),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.phone_rounded, 'Teléfono', order.customerPhone),
            const SizedBox(height: 10),
            _buildInfoRow(
              order.isDelivery
                  ? Icons.location_on_rounded
                  : Icons.storefront_rounded,
              order.isDelivery ? 'Dirección' : 'Modalidad',
              order.deliveryAddress,
            ),
            if (order.referenceAddress.isNotEmpty) ...[
              const SizedBox(height: 10),
              _buildInfoRow(Icons.info_outline, 'Referencia',
                  order.referenceAddress),
            ],
            const SizedBox(height: 10),
            _buildInfoRow(
                Icons.payment_rounded, 'Método de Pago', order.paymentMethod),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 10),
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value,
      {bool highlightGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: highlightGreen ? AppColors.secondary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
