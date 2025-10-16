import 'package:flutter/material.dart';
import '../paleta.dart';
import '../widgets/boton_primario.dart';

class EditarPerfilPantalla extends StatefulWidget {
  const EditarPerfilPantalla({super.key});

  @override
  State<EditarPerfilPantalla> createState() => _EditarPerfilPantallaState();
}

class _EditarPerfilPantallaState extends State<EditarPerfilPantalla> {
  final _formKey = GlobalKey<FormState>();

  // Campos editables
  String nombre = 'Juan Pérez';
  String correo = 'juan.perez@email.com';
  String telefono = '+591 71234567';
  String direccion = 'Av. Central #123, La Paz';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Perfil',
          style: TextStyle(color: Colors.white), // color del texto
        ),
        backgroundColor: AppTheme.primaryColor, // color de fondo del AppBar
        iconTheme: const IconThemeData(color: Colors.white), // color de los iconos
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Nombre
              TextFormField(
                initialValue: nombre,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => nombre = value,
                validator: (value) =>
                    value!.isEmpty ? 'El nombre no puede estar vacío' : null,
              ),
              const SizedBox(height: 16),

              // Correo
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

              // Teléfono
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

              // Dirección
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

              // Botón Guardar usando BotonPrimario
              BotonPrimario(
                label: 'Guardar Cambios',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Perfil actualizado correctamente'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.pop(context); // Volver al perfil
                  }
                },
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
