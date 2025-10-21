import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../paleta.dart';
import '../providers/carrito.dart';
import 'ubicacion_envio_pantalla.dart';

class CarritoPantalla extends StatelessWidget {
  const CarritoPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 Obtiene el tema dinámico desde el provider
    final themeProvider = Provider.of<AppTheme>(context);

    // 🔹 Obtiene el carrito desde el provider
    final carrito = Provider.of<Carrito>(context);

    // 🔹 Lista de productos y total calculado automáticamente
    final listaProductos = carrito.productos;
    final total = carrito.calcularTotal();

    // 🔹 Sugerencias de productos para mostrar al final
    final sugerencias = [
      {
        'nombre': 'Pan integral 500g',
        'precio': 'Bs 6',
        'imagen':
            'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=200',
      },
      {
        'nombre': 'Leche descremada 1L',
        'precio': 'Bs 8',
        'imagen':
            'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=200',
      },
      {
        'nombre': 'Huevos 6u',
        'precio': 'Bs 12',
        'imagen':
            'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?w=200',
      },
      {
        'nombre': 'Aceite de oliva 500ml',
        'precio': 'Bs 20',
        'imagen':
            'https://images.unsplash.com/photo-1573383678063-32d3aad7e8c8?w=200',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito', style: TextStyle(color: Colors.white)),
        backgroundColor: themeProvider.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: listaProductos.isEmpty
          // 🔹 Mostrar mensaje si el carrito está vacío
          ? Center(
              child: Text(
                'Tu carrito está vacío',
                style: TextStyle(color: themeProvider.primaryColor),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 260),
              itemCount: listaProductos.length,
              itemBuilder: (context, index) {
                final producto = listaProductos[index];
                final cantidad = carrito.cantidad(producto['nombre']);

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          producto['imagen'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              producto['nombre'],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: themeProvider.primaryColor,
                              ),
                            ),
                            Text(
                              producto['precio'],
                              style: TextStyle(
                                color: themeProvider.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          // 🔹 Quitar producto del carrito
                          IconButton(
                            icon: const Icon(Icons.remove, size: 20),
                            onPressed: () =>
                                carrito.quitarProducto(producto['nombre']),
                          ),
                          Text(
                            '$cantidad',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: themeProvider.primaryColor,
                            ),
                          ),
                          // 🔹 Agregar producto al carrito
                          IconButton(
                            icon: const Icon(Icons.add, size: 20),
                            onPressed: () => carrito.agregarProducto(producto),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Lista horizontal de sugerencias
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: sugerencias.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final sugerencia = sugerencias[index];
                  return Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Image.network(
                            sugerencia['imagen']!,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sugerencia['nombre']!,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: themeProvider.primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                sugerencia['precio']!,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: themeProvider.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                height: 28,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: themeProvider.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  onPressed: () => carrito.agregarProducto({
                                    'nombre': sugerencia['nombre']!,
                                    'precio': sugerencia['precio']!,
                                    'imagen': sugerencia['imagen']!,
                                  }),
                                  child: const Icon(
                                    Icons.add,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            // 🔹 Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.primaryColor,
                  ),
                ),
                Text(
                  'Bs ${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 🔹 Botón PEDIR
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeProvider.accentColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UbicacionEnvioPantalla(total: total),
                  ),
                );
              },
              child: Text(
                'PEDIR',
                style: TextStyle(
                  color: themeProvider.secundaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
