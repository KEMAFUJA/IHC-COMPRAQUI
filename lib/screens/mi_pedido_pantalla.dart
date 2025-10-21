import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../paleta.dart';
import '../widgets/animacion_card.dart';
import '../widgets/card_item.dart';
import '../providers/pedidos.dart';
import 'viaje_pedido_pantalla.dart';

class MiPedidoPantalla extends StatelessWidget {
  const MiPedidoPantalla({super.key});

  Color _estadoColor(String estado) {
    switch (estado) {
      case "Preparando":
        return Colors.orange;
      case "En camino":
        return Colors.blue;
      case "Entregado":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context);       // Colores
    final pedidosProvider = Provider.of<Pedidos>(context);
    final pedidosActivos = pedidosProvider.pedidosActivos;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    appTheme.primaryColor.withOpacity(0.9),
                    appTheme.primaryColor,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mis Pedidos',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Aquí puedes ver y hacer seguimiento a tus pedidos activos',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Activos', '${pedidosProvider.totalActivos()}', Icons.local_shipping, appTheme),
                    _buildStatItem('Completados', '0', Icons.check_circle_outline, appTheme),
                    _buildStatItem('Cancelados', '0', Icons.cancel_outlined, appTheme),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: pedidosActivos.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 80),
                        child: Text('No tienes pedidos activos 😔', style: TextStyle(fontSize: 16)),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 16),
                          child: Text(
                            'Pedidos Activos',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        ...List.generate(pedidosActivos.length, (index) {
                          final pedido = pedidosActivos[index];
                          final resumenProductos = pedido["productos"]
                              .map<String>((p) => "${p["cantidad"]} x ${p["nombre"]}")
                              .join(", ");
                          final total = (pedido["total"] + pedido["envio"]).toStringAsFixed(2);

                          return AnimacionCard(
                            index: index,
                            child: CardItem(
  icon: Icons.receipt_long,
  title: 'Pedido #${pedido["id"]}',
  subtitle: '$resumenProductos\nTotal: Bs $total - Estado: ${pedido["estado"]}',
  titleStyle: const TextStyle(
    fontSize: 14,      // 🔹 tamaño más pequeño para el título
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  ),
  subtitleStyle: const TextStyle(
    fontSize: 12,      // 🔹 tamaño más pequeño para el subtítulo
    color: Colors.grey,
  ),
  trailing: Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: _estadoColor(pedido["estado"]),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      pedido["estado"],
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TrackingPedidoPantalla(
          totalPedido: pedido["total"],
          costoEnvio: pedido["envio"],
        ),
      ),
    );
  },
  secondaryButton: TextButton(
    onPressed: () => pedidosProvider.eliminarPedido(index),
    child: const Text(
      'Cancelar',
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),

                          );
                        }),
                      ],
                    ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, AppTheme appTheme) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: appTheme.primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: appTheme.primaryColor, size: 20),
        ),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87)),
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
