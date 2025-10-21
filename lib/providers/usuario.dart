import 'package:flutter/material.dart';

// 📦 Provider que guarda los datos del usuario
class Usuario extends ChangeNotifier {
  String nombre = 'Juan Pérez';
  String correo = 'juan.perez@email.com';
  String telefono = '+591 71234567';
  String direccion = 'Av. Central #123, La Paz';
  int puntosFidelidad = 245;

  // Función para actualizar datos
  void actualizarPerfil({
    required String nuevoNombre,
    required String nuevoCorreo,
    required String nuevoTelefono,
    required String nuevaDireccion,
  }) {
    nombre = nuevoNombre;
    correo = nuevoCorreo;
    telefono = nuevoTelefono;
    direccion = nuevaDireccion;
    notifyListeners(); // 🔔 Notifica a todos los widgets que usan este provider
  }

  // Opcional: actualizar puntos
  void actualizarPuntos(int nuevosPuntos) {
    puntosFidelidad = nuevosPuntos;
    notifyListeners();
  }
}
