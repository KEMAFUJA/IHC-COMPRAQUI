import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../paleta.dart';
import '../providers/productos.dart';
import 'ubicacion_envio_pantalla.dart';

class DetalleCompraPantalla extends StatelessWidget {
  final Map<String, dynamic> compra;

  const DetalleCompraPantalla({super.key, required this.compra});

  @override
  Widget build(BuildContext context) {
    final themeProvider = AppTheme(); // Para colores de UI
    final productosProvider = Provider.of<Productos>(context);

    // Inicializar la compra si la lista está vacía
    if (productosProvider.productos.isEmpty) {
      productosProvider.inicializarCompra(compra);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalle de Compra',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: themeProvider.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeader(themeProvider, productosProvider),
            const SizedBox(height: 16),
            Expanded(
              child: _buildListaProductos(
                themeProvider,
                productosProvider,
                context,
              ),
            ),
            const SizedBox(height: 16),
            _buildAgregarProducto(themeProvider, productosProvider, context),
            const SizedBox(height: 20),
            _buildTotalYRepetirCompra(
              themeProvider,
              productosProvider,
              context,
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Header con cantidad de productos
  Widget _buildHeader(AppTheme theme, Productos productosProvider) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.receipt_long, color: theme.primaryColor, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Productos en la compra',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    'Total: ${productosProvider.productos.length} producto${productosProvider.productos.length != 1 ? 's' : ''}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Lista de productos
  Widget _buildListaProductos(
    AppTheme theme,
    Productos productosProvider,
    BuildContext context,
  ) {
    if (productosProvider.productos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No hay productos',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Agrega productos a tu compra',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: productosProvider.productos.length,
      itemBuilder: (context, index) {
        final p = productosProvider.productos[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _buildIconoProducto(theme),
                const SizedBox(width: 12),
                _buildInfoProducto(p, theme),
                const SizedBox(width: 12),
                _buildControlesCantidad(index, p, theme, productosProvider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildIconoProducto(AppTheme theme) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons.shopping_basket, color: theme.primaryColor, size: 20),
    );
  }

  Widget _buildInfoProducto(Map<String, dynamic> p, AppTheme theme) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            p['nombre'],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '${p['precio']}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlesCantidad(
    int index,
    Map<String, dynamic> p,
    AppTheme theme,
    Productos productosProvider,
  ) {
    return Column(
      children: [
        _buildCantidadControl(index, p, theme, productosProvider),
        const SizedBox(height: 8),
        _buildBotonEliminar(index, productosProvider),
      ],
    );
  }

  Widget _buildCantidadControl(
    int index,
    Map<String, dynamic> p,
    AppTheme theme,
    Productos productosProvider,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCantidadBoton(
            Icons.remove,
            () => productosProvider.disminuirCantidad(index),
            left: true,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              '${p['cantidad']}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          _buildCantidadBoton(
            Icons.add,
            () => productosProvider.aumentarCantidad(index),
            color: theme.primaryColor,
            left: false,
          ),
        ],
      ),
    );
  }

  Widget _buildCantidadBoton(
    IconData icon,
    VoidCallback onTap, {
    Color? color,
    bool left = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.only(
          topLeft: left ? const Radius.circular(20) : Radius.zero,
          bottomLeft: left ? const Radius.circular(20) : Radius.zero,
          topRight: !left ? const Radius.circular(20) : Radius.zero,
          bottomRight: !left ? const Radius.circular(20) : Radius.zero,
        ),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 18, color: color ?? Colors.grey[700]),
        ),
      ),
    );
  }

  Widget _buildBotonEliminar(int index, Productos productosProvider) {
    return SizedBox(
      width: 100,
      child: OutlinedButton.icon(
        onPressed: () => productosProvider.eliminarProducto(index),
        icon: const Icon(Icons.delete_outline, size: 16),
        label: const Text('Eliminar', style: TextStyle(fontSize: 12)),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildAgregarProducto(
    AppTheme theme,
    Productos productosProvider,
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.primaryColor, theme.primaryColor.withOpacity(0.8)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            final productosDisponibles = [
              {'nombre': 'Azúcar 1kg', 'precio': 'Bs 10'},
              {'nombre': 'Café 250g', 'precio': 'Bs 12'},
              {'nombre': 'Aceite 1L', 'precio': 'Bs 20'},
            ];

            final Map<String, dynamic>? productoSeleccionado = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Agregar Producto'),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: productosDisponibles.length,
                      itemBuilder: (context, index) {
                        final p = productosDisponibles[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(p['nombre'] ?? 'Producto desconocido'),
                            subtitle: Text('Precio: ${p['precio']}'),
                            onTap: () => Navigator.of(context).pop(p),
                          ),
                        );
                      },
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar'),
                    ),
                  ],
                );
              },
            );

            if (productoSeleccionado != null) {
              productosProvider.agregarProducto({
                'nombre': productoSeleccionado['nombre'],
                'cantidad': 1,
                'precio': productoSeleccionado['precio'],
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Agregar Producto',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalYRepetirCompra(
    AppTheme theme,
    Productos productosProvider,
    BuildContext context,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Bs ${productosProvider.calcularTotal()}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.repeat),
                label: const Text(
                  'Repetir Compra',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UbicacionEnvioPantalla(
                      total: productosProvider.calcularTotal(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
