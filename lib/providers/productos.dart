import 'package:flutter/material.dart';

class Productos with ChangeNotifier {
  // Lista de productos en la compra
  List<Map<String, dynamic>> _productos = [];

  // Obtener lista de productos
  List<Map<String, dynamic>> get productos => _productos;

  // Inicializar la lista con la compra actual
  void inicializarCompra(Map<String, dynamic> compra) {
    _productos = [
      {
        'nombre': compra['producto'],
        'cantidad': 1,
        'precio': compra['total'],
      }
    ];
    notifyListeners();
  }

  // Agregar un producto
  void agregarProducto(Map<String, dynamic> producto) {
    _productos.add(producto);
    notifyListeners();
  }

  // Eliminar un producto por índice
  void eliminarProducto(int index) {
    _productos.removeAt(index);
    notifyListeners();
  }

  // Aumentar cantidad de un producto
  void aumentarCantidad(int index) {
    _productos[index]['cantidad']++;
    notifyListeners();
  }

  // Disminuir cantidad de un producto
  void disminuirCantidad(int index) {
    if (_productos[index]['cantidad'] > 1) {
      _productos[index]['cantidad']--;
      notifyListeners();
    }
  }

  // Calcular el total de la compra
  double calcularTotal() {
    double total = 0;
    for (var p in _productos) {
      final precioStr = p['precio']!.toString().replaceAll('Bs ', '');
      final precio = double.tryParse(precioStr) ?? 0;
      total += precio * p['cantidad'];
    }
    return total;
  }
}
