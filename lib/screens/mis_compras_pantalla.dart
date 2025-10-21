import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/animacion_card.dart';
import '../widgets/card_item.dart';
import '../paleta.dart';
import '../providers/compras.dart';
import 'detalle_compra_pantalla.dart';

class MisCompraspantalla extends StatelessWidget {
  const MisCompraspantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();

    // 🔹 Obtiene la lista de compras desde el Provider
    final compras = context.watch<Compras>().compras;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Header con gradiente
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
                    'Mis Compras',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Historial de tus pedidos recientes',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 🔹 Contador de compras
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
                    _buildStatItem('Total Compras', '${compras.length}', Icons.shopping_cart, appTheme),
                    _buildStatItem('Este Mes', '3', Icons.calendar_today, appTheme),
                    _buildStatItem('Gastado', _calcularTotal(compras), Icons.attach_money, appTheme),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🔹 Lista de compras
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 16),
                    child: Text(
                      'Compras Recientes',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                    ),
                  ),
                  
                  ...List.generate(compras.length, (index) {
                    final compra = compras[index];
                    return AnimacionCard(
                      index: index,
                      child: CardItem(
  icon: Icons.shopping_bag,
  title: compra['producto'] as String,
  subtitle: 'Fecha: ${compra['fecha']} - Total: ${compra['total']} - Estado: ${compra['estado']}',
  titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),  // 🔹 más pequeño
  subtitleStyle: const TextStyle(fontSize: 12),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalleCompraPantalla(compra: compra),
      ),
    );
  },
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

  // 🔹 Widget para mostrar estadísticas
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
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // 🔹 Función para calcular el total gastado
  String _calcularTotal(List<Map<String, dynamic>> compras) {
    double total = 0;
    for (var compra in compras) {
      // Extrae el número de la cadena "Bs 15"
      String valorStr = (compra['total'] as String).replaceAll('Bs ', '');
      total += double.tryParse(valorStr) ?? 0;
    }
    return 'Bs $total';
  }
}
