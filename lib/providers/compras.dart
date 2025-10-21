import 'package:flutter/material.dart';

class Compras with ChangeNotifier {
  // Lista interna de compras
  final List<Map<String, dynamic>> _compras = [
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

  // Obtener lista de compras
  List<Map<String, dynamic>> get compras => _compras;

  // Agregar una compra
  void agregarCompra(Map<String, dynamic> compra) {
    _compras.add(compra);
    notifyListeners(); // ⚡ Notifica a los widgets escuchando
  }

  // Eliminar una compra por índice
  void eliminarCompra(int index) {
    _compras.removeAt(index);
    notifyListeners();
  }

  // Limpiar todas las compras
  void limpiarCompras() {
    _compras.clear();
    notifyListeners();
  }
}
