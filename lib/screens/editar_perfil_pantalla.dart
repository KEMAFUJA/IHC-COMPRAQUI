import 'package:flutter/material.dart';
import '../paleta.dart';
import '../widgets/boton_primario.dart';

class EditarPerfilPantalla extends StatefulWidget {
  const EditarPerfilPantalla({super.key});

  @override
  State<EditarPerfilPantalla> createState() => _EditarPerfilPantallaState();
}

class _EditarPerfilPantallaState extends State<EditarPerfilPantalla> {
  // 🔑 Clave para el formulario, permite validar campos
  final _formKey = GlobalKey<FormState>();

  // 📄 Campos editables del perfil
  String nombre = 'Juan Pérez';
  String correo = 'juan.perez@email.com';
  String telefono = '+591 71234567';
  String direccion = 'Av. Central #123, La Paz';

  @override
  Widget build(BuildContext context) {
    // 🎨 Instancia de AppTheme para acceder a colores globales
    final appTheme = AppTheme();

    return Scaffold(
      // 🟢 Barra superior
      appBar: AppBar(
        title: const Text(
          'Editar Perfil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appTheme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // 📝 Formulario para editar los datos
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // ---------------------
              // Campo Nombre
              // ---------------------
              TextFormField(
                initialValue: nombre,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => nombre = value, // Actualiza variable
                validator: (value) =>
                    value!.isEmpty ? 'El nombre no puede estar vacío' : null,
              ),
              const SizedBox(height: 16),

              // ---------------------
              // Campo Correo
              // ---------------------
              TextFormField(
                initialValue: correo,
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => correo = value,
                validator: (value) =>
                    value!.isEmpty ? 'El correo no puede estar vacío' : null,
              ),
              const SizedBox(height: 16),

              // ---------------------
              // Campo Teléfono
              // ---------------------
              TextFormField(
                initialValue: telefono,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => telefono = value,
                validator: (value) =>
                    value!.isEmpty ? 'El teléfono no puede estar vacío' : null,
              ),
              const SizedBox(height: 16),

              // ---------------------
              // Campo Dirección
              // ---------------------
              TextFormField(
                initialValue: direccion,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => direccion = value,
                validator: (value) =>
                    value!.isEmpty ? 'La dirección no puede estar vacía' : null,
              ),
              const SizedBox(height: 32),

              // ---------------------
              // Botón Guardar Cambios
              // ---------------------
              BotonPrimario(
                label: 'Guardar Cambios',
                onPressed: _guardarCambios, // Llamada a función definida abajo
                width: double.infinity,
                color: appTheme.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================
  // Función para guardar cambios del perfil
  // =====================
  void _guardarCambios() {
    // ✅ Valida que todos los campos sean correctos
    if (_formKey.currentState!.validate()) {
      // 🔔 Muestra mensaje de confirmación
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perfil actualizado correctamente'),
          duration: Duration(seconds: 2),
        ),
      );

      // 🔙 Regresa a la pantalla anterior (Perfil)
      Navigator.pop(context);
    }
  }
}
