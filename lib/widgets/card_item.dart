import 'package:flutter/material.dart';
import '../paleta.dart';

class CardItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  // 🆕 Parámetros opcionales
  final Widget? trailing;
  final Widget? secondaryButton;

  const CardItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.trailing,
    this.secondaryButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🧾 Contenido principal (icono, título, subtítulo, trailing)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 36, color: AppTheme.primaryColor),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: Theme.of(context).textTheme.displayMedium),
                      const SizedBox(height: 4),
                      Text(subtitle,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
                // 🆕 Si hay trailing (estado u otro widget), lo muestra
                if (trailing != null) trailing!,
                if (trailing == null)
                  const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey),
              ],
            ),

            // 🆕 Botón secundario (opcional)
            if (secondaryButton != null) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: secondaryButton!,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
