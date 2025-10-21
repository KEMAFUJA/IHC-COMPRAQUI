import 'package:flutter/material.dart';

class Carrito extends ChangeNotifier {
  final List<Map<String, dynamic>> _productos = [];

  List<Map<String, dynamic>> get productos => _productos;

  void agregarProducto(Map<String, dynamic> producto) {
    _productos.add(producto);
    notifyListeners();
  }

  void quitarProducto(String nombre) {
    _productos.removeWhere((p) => p['nombre'] == nombre);
    notifyListeners();
  }

  int cantidad(String nombre) =>
      _productos.where((p) => p['nombre'] == nombre).length;

  int totalItems() => _productos.length;

  double calcularTotal() {
    double total = 0;
    for (var p in _productos) {
      final precioString =
          p['precio'].toString().replaceAll(RegExp(r'[^\d.]'), '');
      final precio = double.tryParse(precioString) ?? 0;
      total += precio;
    }
    return total;
  }

  void vaciar() {
    _productos.clear();
    notifyListeners();
  }
}
