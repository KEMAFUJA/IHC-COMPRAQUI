import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/animacion_card.dart';
import '../paleta.dart';
import '../providers/carrito.dart';
import 'carrito_pantalla.dart';

class Catalogopantalla extends StatefulWidget {
  const Catalogopantalla({super.key});

  @override
  State<Catalogopantalla> createState() => _CatalogopantallaState();
}

class _CatalogopantallaState extends State<Catalogopantalla> {
  // 🔹 Lista de productos del catálogo
  final List<Map<String, dynamic>> productos = [
    {
      'nombre': 'Arroz 1kg',
      'precio': 'Bs 15',
      'imagen':
          'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400',
      'categoria': 'Comida'
    },
    {
      'nombre': 'Leche 1L',
      'precio': 'Bs 8',
      'imagen':
          'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400',
      'categoria': 'Comida'
    },
    {
      'nombre': 'Pan integral',
      'precio': 'Bs 5',
      'imagen':
          'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400',
      'categoria': 'Comida'
    },
    {
      'nombre': 'Azúcar 1kg',
      'precio': 'Bs 10',
      'imagen':
          'https://images.unsplash.com/photo-1599595373755-b445ca0d0ed0?w=400',
      'categoria': 'Comida'
    },
    {
      'nombre': 'Televisor 50"',
      'precio': 'Bs 2800',
      'imagen':
          'https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04?w=400',
      'categoria': 'Electrodomésticos'
    },
    {
      'nombre': 'Camisa Negra',
      'precio': 'Bs 120',
      'imagen':
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
      'categoria': 'Ropa'
    },
    {
      'nombre': 'Refrigerador 300L',
      'precio': 'Bs 4000',
      'imagen':
          'https://images.unsplash.com/photo-1627599071449-0057f551d734?w=400',
      'categoria': 'Electrodomésticos'
    },
    {
      'nombre': 'Zapatillas deportivas',
      'precio': 'Bs 350',
      'imagen':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
      'categoria': 'Ropa'
    },
  ];

  // 🔹 Categoría seleccionada para filtrar productos
  String categoriaSeleccionada = 'Todo';

  final List<String> categorias = [
    'Todo',
    'Comida',
    'Ropa',
    'Electrodomésticos',
    'Tecnología',
    'Hogar',
  ];

  @override
  Widget build(BuildContext context) {
    // 🔹 Tema dinámico desde Provider
    final themeProvider = Provider.of<AppTheme>(context);

    // 🔹 Carrito global desde Provider
    final carrito = Provider.of<Carrito>(context);

    // 🔹 Filtra productos según categoría seleccionada
    final productosFiltrados = categoriaSeleccionada == 'Todo'
        ? productos
        : productos.where((p) => p['categoria'] == categoriaSeleccionada).toList();

    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // 🔹 CABECERA
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [themeProvider.primaryColor, themeProvider.primaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
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
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            )),
                    const SizedBox(height: 4),
                    Text('Descubre nuestros productos',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            )),
                    const SizedBox(height: 8),
                    // 🔹 Barra de búsqueda (sin funcionalidad por ahora)
                    Container(
                      height: 30,
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

          // 🔹 BOTONES DE CATEGORÍAS
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categorias.length,
                itemBuilder: (context, index) {
                  final cat = categorias[index];
                  final seleccionada = cat == categoriaSeleccionada;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: seleccionada,
                      onSelected: (_) {
                        setState(() {
                          categoriaSeleccionada = cat;
                        });
                      },
                      selectedColor: themeProvider.primaryColor,
                      backgroundColor:
                          themeProvider.backgroundColor.withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: seleccionada ? Colors.white : themeProvider.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // 🔹 GRID DE PRODUCTOS
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final producto = productosFiltrados[index];
                  return AnimacionCard(
                    index: index,
                    child: _buildProductCard(producto, themeProvider, carrito),
                  );
                },
                childCount: productosFiltrados.length,
              ),
            ),
          ),
        ],
      ),

      // 🔹 BOTÓN FLOTANTE DEL CARRITO
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CarritoPantalla()),
          );
        },
        backgroundColor: themeProvider.primaryColor,
        foregroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Badge(
          label: Text('${carrito.totalItems()}'),
          child: const Icon(Icons.shopping_cart),
        ),
      ),
    );
  }

  // 🔹 CARD DE PRODUCTO
  Widget _buildProductCard(Map<String, dynamic> producto, AppTheme themeProvider,
      Carrito carrito) {
    return Container(
      decoration: BoxDecoration(
        color: themeProvider.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Image.network(producto['imagen'].toString(),
                height: 100, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(producto['categoria'].toString(),
                    style: TextStyle(
                        fontSize: 10,
                        color: themeProvider.textColor.withOpacity(0.6),
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(producto['nombre'].toString(),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: themeProvider.textColor)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(producto['precio'].toString(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: themeProvider.primaryColor)),
                    const Spacer(),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                          color: themeProvider.primaryColor,
                          borderRadius: BorderRadius.circular(6)),
                      child: IconButton(
                        icon: const Icon(Icons.add, size: 14, color: Colors.white),
                        padding: EdgeInsets.zero,
                        // 🔹 Agrega producto al carrito usando Provider
                        onPressed: () {
                          carrito.agregarProducto(producto);
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
