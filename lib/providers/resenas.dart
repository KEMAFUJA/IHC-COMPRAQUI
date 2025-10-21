import 'package:flutter/material.dart';

class Resenas with ChangeNotifier {
  // Lista de reseñas
  List<Map<String, dynamic>> _resenas = [];

  // Obtener todas las reseñas
  List<Map<String, dynamic>> get resenas => _resenas;

  // Agregar una reseña
  void agregarResena(Map<String, dynamic> resena) {
    _resenas.add(resena);
    notifyListeners(); // Notifica cambios a las pantallas que escuchan
  }

  // Eliminar una reseña por índice
  void eliminarResena(int index) {
    if (index >= 0 && index < _resenas.length) {
      _resenas.removeAt(index);
      notifyListeners();
    }
  }

  // Obtener promedio de estrellas
  double promedioEstrellas() {
    if (_resenas.isEmpty) return 0.0;
    double totalEstrellas = 0.0;
    for (var r in _resenas) {
      totalEstrellas += r['estrellas'] ?? 0;
    }
    return totalEstrellas / _resenas.length;
    return totalEstrellas / _resenas.length;
  }

  // Obtener número total de reseñas
  int totalResenas() => _resenas.length;

  // Limpiar todas las reseñas
  void limpiarResenas() {
    _resenas.clear();
    notifyListeners();
  }
}
