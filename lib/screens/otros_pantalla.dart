import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../paleta.dart';
import '../widgets/animacion_card.dart';
import '../widgets/card_item.dart';
import 'cambiar_tema_pantalla.dart';

class Otrospantalla extends StatelessWidget {
  const Otrospantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Provider.of<AppTheme>(context); // 🔹 Instancia de AppTheme

    final List<Map<String, dynamic>> opciones = [
      {
        "icon": Icons.color_lens,
        "titulo": "Cambiar color",
        "subtitulo": "Personaliza el tema de la app",
        "accion": () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CambiarTemaPantalla(),
            ),
          );
        },
      },
      {
        "icon": Icons.language,
        "titulo": "Cambiar idioma",
        "subtitulo": "Selecciona tu idioma preferido",
        "accion": () {},
      },
      {
        "icon": Icons.notifications,
        "titulo": "Notificaciones",
        "subtitulo": "Activa o desactiva alertas",
        "accion": () {},
      },
      {
        "icon": Icons.lock,
        "titulo": "Privacidad",
        "subtitulo": "Configura tu información personal",
        "accion": () {},
      },
      {
        "icon": Icons.help_outline,
        "titulo": "Ayuda / Soporte",
        "subtitulo": "Contacta soporte o consulta FAQ",
        "accion": () {},
      },
      {
        "icon": Icons.info_outline,
        "titulo": "Acerca de la app",
        "subtitulo": "Versión, créditos y más información",
        "accion": () {},
      },
    ];

    return Scaffold(
      backgroundColor: tema.backgroundColor, // 🔹 Color de fondo dinámico
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con degradado
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    tema.primaryColor.withOpacity(0.9), // 🔹 color dinámico
                    tema.primaryColor,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Otros',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Opciones adicionales y configuraciones',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white.withOpacity(0.9)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Lista de opciones
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: List.generate(opciones.length, (index) {
                  final opcion = opciones[index];
                  return AnimacionCard(
                    index: index,
                    child: CardItem(
                      icon: opcion["icon"],
                      title: opcion["titulo"],
                      subtitle: opcion["subtitulo"],
                      onTap: opcion["accion"],
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
