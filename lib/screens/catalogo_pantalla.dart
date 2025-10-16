import 'package:flutter/material.dart';
import '../widgets/animacion_card.dart';
import '../paleta.dart';
import 'carrito_pantalla.dart';

class Catalogopantalla extends StatefulWidget {
  const Catalogopantalla({super.key});

  @override
  State<Catalogopantalla> createState() => _CatalogopantallaState();
}

class _CatalogopantallaState extends State<Catalogopantalla> {
  final List<Map<String, dynamic>> productos = [
    {
      'nombre': 'Arroz 1kg',
      'precio': 'Bs 15',
      'imagen': 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400',
      'categoria': 'Granos'
    },
    {
      'nombre': 'Leche 1L',
      'precio': 'Bs 8',
      'imagen': 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400',
      'categoria': 'Lácteos'
    },
    {
      'nombre': 'Pan integral',
      'precio': 'Bs 5',
      'imagen': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400',
      'categoria': 'Panadería'
    },
    {
      'nombre': 'Azúcar 1kg',
      'precio': 'Bs 10',
      'imagen': 'https://images.unsplash.com/photo-1599595373755-b445ca0d0ed0?w=400',
      'categoria': 'Endulzantes'
    },
    {
      'nombre': 'Huevos 12u',
      'precio': 'Bs 20',
      'imagen': 'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?w=400',
      'categoria': 'Lácteos'
    },
    {
      'nombre': 'Aceite 1L',
      'precio': 'Bs 18',
      'imagen': 'https://images.unsplash.com/photo-1573383678063-32d3aad7e8c8?w=400',
      'categoria': 'Aceites'
    },
  ];

  List<Map<String, dynamic>> carrito = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppTheme.primaryColor, AppTheme.primaryColor],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Catálogo',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            )),
                    const SizedBox(height: 4),
                    Text('Descubre nuestros productos',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            )),
                    const SizedBox(height: 8),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Buscar productos...',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.72),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final producto = productos[index];
                  return AnimacionCard(
                    index: index,
                    child: _buildProductCard(producto),
                  );
                },
                childCount: productos.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CarritoPantalla(carrito: carrito)),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Badge(
          label: Text('${carrito.length}'),
          child: const Icon(Icons.shopping_cart),
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> producto) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Image.network(producto['imagen'].toString(), height: 100, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(producto['categoria'].toString(),
                    style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(producto['nombre'].toString(),
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(producto['precio'].toString(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.primaryColor)),
                    const Spacer(),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(6)),
                      child: IconButton(
                        icon: const Icon(Icons.add, size: 14, color: Colors.white),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            carrito.add(producto);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
