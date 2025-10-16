import 'package:flutter/material.dart';
import '../widgets/animacion_card.dart';
import '../widgets/card_item.dart';
import '../paleta.dart';
import 'detalle_compra_pantalla.dart';

class MisCompraspantalla extends StatelessWidget {
  const MisCompraspantalla({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de compras de ejemplo
    final compras = [
      {
        'producto': 'Arroz 1kg',
        'fecha': '05/10/2025', 
        'total': 'Bs 15',
        'estado': 'Entregado',
        'color': Colors.green
      },
      {
        'producto': 'Leche 1L',
        'fecha': '04/10/2025',
        'total': 'Bs 8',
        'estado': 'Entregado',
        'color': Colors.green
      },
      {
        'producto': 'Pan integral',
        'fecha': '03/10/2025',
        'total': 'Bs 5',
        'estado': 'En proceso',
        'color': Colors.orange
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryColor.withOpacity(0.9),
                    AppTheme.primaryColor,
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

            // Contador de compras
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
                    _buildStatItem('Total Compras', '${compras.length}', Icons.shopping_cart),
                    _buildStatItem('Este Mes', '3', Icons.calendar_today),
                    _buildStatItem('Gastado', 'Bs 28', Icons.attach_money),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Lista de compras
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
                        subtitle: 'Fecha: ${compra['fecha']} - Total: ${compra['total']} - Estado: ${compra['estado']}' as String,
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

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppTheme.primaryColor, size: 20),
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
}
