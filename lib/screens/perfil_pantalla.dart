import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/boton_primario.dart';
import '../paleta.dart';
import 'editar_perfil_pantalla.dart';
import '../providers/usuario.dart';

class Perfilpantalla extends StatelessWidget {
  const Perfilpantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();

    // 📦 Escucha los cambios del usuario desde Usuario
    final user = context.watch<Usuario>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ------------------------
            // Header con fondo y avatar
            // ------------------------
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    appTheme.primaryColor.withOpacity(0.8),
                    appTheme.primaryColor,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: const NetworkImage(
                            'https://i.pravatar.cc/150?img=3'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // 🔔 Nombre dinámico
                    Text(
                      user.nombre,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    // 🔔 Correo dinámico
                    Text(
                      user.correo,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ------------------------
            // Tarjeta de información personal
            // ------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _infoRow(
                        Icons.phone_outlined,
                        'Teléfono',
                        user.telefono, // 🔔 Dinámico
                        Colors.blue[600]!,
                      ),
                      const Divider(height: 30),
                      _infoRow(
                        Icons.location_on_outlined,
                        'Dirección',
                        user.direccion, // 🔔 Dinámico
                        Colors.green[600]!,
                      ),
                      const Divider(height: 30),
                      _infoRow(
                        Icons.card_giftcard_outlined,
                        'Puntos de fidelidad',
                        '${user.puntosFidelidad} puntos', // 🔔 Dinámico
                        Colors.orange[600]!,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ------------------------
            // Botones de acción
            // ------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  // Botón Editar Perfil
                  BotonPrimario(
                    label: 'Editar Perfil',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditarPerfilPantalla(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  // Botón Cerrar Sesión
                  BotonPrimario(
                    label: 'Cerrar Sesión',
                    onPressed: () {
                      // Aquí podrías limpiar el provider o hacer logout
                    },
                    color: Colors.red[600],
                    outlined: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // =====================
  // Widget para cada fila de información
  // =====================
  Widget _infoRow(IconData icon, String title, String value, Color iconColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
