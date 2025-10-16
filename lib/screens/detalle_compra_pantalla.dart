import 'package:flutter/material.dart';
import '../paleta.dart';

class DetalleCompraPantalla extends StatefulWidget {
  final Map<String, dynamic> compra;

  const DetalleCompraPantalla({super.key, required this.compra});

  @override
  State<DetalleCompraPantalla> createState() => _DetalleCompraPantallaState();
}

class _DetalleCompraPantallaState extends State<DetalleCompraPantalla> {
  late List<Map<String, dynamic>> productos;

  @override
  void initState() {
    super.initState();
    // Lista inicial con el producto de la compra
    productos = [
      {
        'nombre': widget.compra['producto'],
        'cantidad': 1,
        'precio': widget.compra['total']
      },
    ];
  }

  void aumentarCantidad(int index) {
    setState(() {
      productos[index]['cantidad']++;
    });
  }

  void disminuirCantidad(int index) {
    setState(() {
      if (productos[index]['cantidad'] > 1) {
        productos[index]['cantidad']--;
      }
    });
  }

  void eliminarProducto(int index) {
    setState(() {
      productos.removeAt(index);
    });
  }

  void _agregarProducto() async {
    // Lista de productos disponibles (ejemplo)
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
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.shopping_basket, 
                          color: AppTheme.primaryColor, size: 20),
                    ),
                    title: Text(p['nombre'] ?? 'Producto desconocido',
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Precio: ${p['precio']}',
                        style: TextStyle(color: Colors.grey[700])),
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
      setState(() {
        productos.add({
          'nombre': productoSeleccionado['nombre'],
          'cantidad': 1,
          'precio': productoSeleccionado['precio']
        });
      });
    }
  }

  double calcularTotal() {
    double total = 0;
    for (var p in productos) {
      final precioStr = p['precio']!.replaceAll('Bs ', '');
      final precio = double.tryParse(precioStr) ?? 0;
      total += precio * p['cantidad'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Compra',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: AppTheme.primaryColor,
        elevation: 2,
        shadowColor: AppTheme.primaryColor.withOpacity(0.3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header informativo
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.receipt_long, 
                        color: AppTheme.primaryColor, size: 24),
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
                            'Total: ${productos.length} producto${productos.length != 1 ? 's' : ''}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Lista de productos
            Expanded(
              child: productos.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined,
                              size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'No hay productos',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Agrega productos a tu compra',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: productos.length,
                      itemBuilder: (context, index) {
                        final p = productos[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                // Icono del producto
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(Icons.shopping_basket,
                                      color: AppTheme.primaryColor, size: 20),
                                ),
                                
                                const SizedBox(width: 12),
                                
                                // Información del producto
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        p['nombre'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${p['precio']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                const SizedBox(width: 12),
                                
                                // Controles de cantidad y eliminar
                                Column(
                                  children: [
                                    // Contador de cantidad
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.grey[300]!),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Botón disminuir
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                              ),
                                              onTap: () => disminuirCantidad(index),
                                              child: Container(
                                                padding: const EdgeInsets.all(8),
                                                child: Icon(Icons.remove,
                                                    size: 18, color: Colors.grey[700]),
                                              ),
                                            ),
                                          ),
                                          
                                          // Cantidad
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                            child: Text(
                                              '${p['cantidad']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          
                                          // Botón aumentar
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomRight: Radius.circular(20),
                                              ),
                                              onTap: () => aumentarCantidad(index),
                                              child: Container(
                                                padding: const EdgeInsets.all(8),
                                                child: Icon(Icons.add,
                                                    size: 18, color: AppTheme.primaryColor),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    const SizedBox(height: 8),
                                    
                                    // Botón eliminar
                                    SizedBox(
                                      width: 100,
                                      child: OutlinedButton.icon(
                                        onPressed: () => eliminarProducto(index),
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
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 16),

            // Botón para agregar producto
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryColor,
                    AppTheme.primaryColor.withOpacity(0.8),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: _agregarProducto,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.add, 
                            color: AppTheme.primaryColor, size: 16),
                      ),
                      const SizedBox(width: 12),
                      const Text(
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
            ),

            const SizedBox(height: 20),

            // Total y botón repetir compra
            Card(
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
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Bs ${calcularTotal()}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Botón repetir compra - CORREGIDO
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.shade600,
                            Colors.green.shade400,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Compra repetida con éxito'),
                                backgroundColor: Colors.green.shade600,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.repeat, color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                              const Text(
                                'Repetir Compra',
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget PrimaryButton corregido (si lo necesitas mantener)
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double width;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}