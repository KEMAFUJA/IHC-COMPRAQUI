import 'package:flutter/material.dart';
import '../paleta.dart';
import 'ubicacion_envio_pantalla.dart';

class CarritoPantalla extends StatefulWidget {
  final List<Map<String, dynamic>> carrito;
  const CarritoPantalla({super.key, required this.carrito});

  @override
  State<CarritoPantalla> createState() => _CarritoPantallaState();
}

class _CarritoPantallaState extends State<CarritoPantalla> {
  late Map<String, Map<String, dynamic>> productosUnicos;
  late Map<String, int> cantidades;

  @override
  void initState() {
    super.initState();
    _recalcularCarrito();
  }

  void _recalcularCarrito() {
    productosUnicos = {};
    cantidades = {};
    for (var p in widget.carrito) {
      final key = p['nombre'];
      if (productosUnicos.containsKey(key)) {
        cantidades[key] = cantidades[key]! + 1;
      } else {
        productosUnicos[key] = p;
        cantidades[key] = 1;
      }
    }
  }

  void _agregarProducto(String nombre, [Map<String, dynamic>? producto]) {
    setState(() {
      if (!productosUnicos.containsKey(nombre) && producto != null) {
        productosUnicos[nombre] = producto;
        cantidades[nombre] = 1;
      } else {
        cantidades[nombre] = cantidades[nombre]! + 1;
      }
    });
  }

  void _quitarProducto(String nombre) {
    setState(() {
      if (cantidades[nombre]! > 1) {
        cantidades[nombre] = cantidades[nombre]! - 1;
      } else {
        productosUnicos.remove(nombre);
        cantidades.remove(nombre);
      }
    });
  }

  double _calcularTotal() {
    double total = 0;
    productosUnicos.forEach((nombre, producto) {
      final cantidad = cantidades[nombre] ?? 1;
      final precioString =
          producto['precio'].toString().replaceAll(RegExp(r'[^\d.]'), '');
      final precio = double.tryParse(precioString) ?? 0;
      total += precio * cantidad;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final listaProductos = productosUnicos.values.toList();
    final total = _calcularTotal();

    final sugerencias = [
      {
        'nombre': 'Pan integral 500g',
        'precio': 'Bs 6',
        'imagen': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=200'
      },
      {
        'nombre': 'Leche descremada 1L',
        'precio': 'Bs 8',
        'imagen': 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=200'
      },
      {
        'nombre': 'Huevos 6u',
        'precio': 'Bs 12',
        'imagen': 'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?w=200'
      },
      {
        'nombre': 'Aceite de oliva 500ml',
        'precio': 'Bs 20',
        'imagen': 'https://images.unsplash.com/photo-1573383678063-32d3aad7e8c8?w=200'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: listaProductos.isEmpty
          ? const Center(child: Text('Tu carrito está vacío'))
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 260),
              itemCount: listaProductos.length,
              itemBuilder: (context, index) {
                final producto = listaProductos[index];
                final cantidad = cantidades[producto['nombre']]!;

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                            Text(producto['nombre'],
                                style: const TextStyle(fontWeight: FontWeight.w600)),
                            Text(producto['precio'],
                                style: const TextStyle(color: AppTheme.primaryColor)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 20),
                            onPressed: () => _quitarProducto(producto['nombre']),
                          ),
                          Text('$cantidad',
                              style: const TextStyle(fontWeight: FontWeight.w600)),
                          IconButton(
                            icon: const Icon(Icons.add, size: 20),
                            onPressed: () => _agregarProducto(producto['nombre']),
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
            // Sugerencias
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
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w600),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                sugerencia['precio']!,
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                height: 28,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: AppTheme.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                  ),
                                  onPressed: () => _agregarProducto(
                                    sugerencia['nombre']!,
                                    {
                                      'nombre': sugerencia['nombre']!,
                                      'precio': sugerencia['precio']!,
                                      'imagen': sugerencia['imagen']!,
                                    },
                                  ),
                                  child: const Icon(Icons.add,
                                      size: 16, color: Colors.white),
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
            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Bs ${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor)),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UbicacionEnvioPantalla(total: total),
                  ),
                );
              },
              child: const Text(
                'PEDIR',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
