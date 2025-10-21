import 'package:flutter/material.dart';

class Pedidos extends ChangeNotifier {
  // Lista de pedidos activos
  final List<Map<String, dynamic>> _pedidosActivos = [
    {
      "id": 101,
      "productos": [
        {"nombre": "Hamburguesa clásica", "cantidad": 2},
        {"nombre": "Refresco", "cantidad": 2},
      ],
      "total": 52.00,
      "envio": 5.00,
      "estado": "Preparando",
    },
    {
      "id": 102,
      "productos": [
        {"nombre": "Pizza familiar", "cantidad": 1},
        {"nombre": "Agua 500ml", "cantidad": 3},
      ],
      "total": 80.00,
      "envio": 6.00,
      "estado": "En camino",
    },
  ];

  List<Map<String, dynamic>> get pedidosActivos => _pedidosActivos;

  // 🔹 Agrega un nuevo pedido
  void agregarPedido(Map<String, dynamic> pedido) {
    _pedidosActivos.add(pedido);
    notifyListeners(); // Notifica cambios a los widgets que usan Provider
  }

  // 🔹 Elimina un pedido por índice
  void eliminarPedido(int index) {
    _pedidosActivos.removeAt(index);
    notifyListeners();
  }

  // 🔹 Actualiza el estado de un pedido
  void actualizarEstado(int index, String nuevoEstado) {
    _pedidosActivos[index]["estado"] = nuevoEstado;
    notifyListeners();
  }

  // 🔹 Calcula la cantidad de pedidos activos
  int totalActivos() => _pedidosActivos.length;
}
