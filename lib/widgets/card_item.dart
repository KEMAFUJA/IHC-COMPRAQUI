import 'package:flutter/material.dart';
import '../paleta.dart';
import 'package:provider/provider.dart';

class CardItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Widget? trailing;
  final Widget? secondaryButton;

  // 🔹 Nuevas propiedades para personalizar el estilo
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const CardItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.trailing,
    this.secondaryButton,
    this.titleStyle,     // 🔹 opcional
    this.subtitleStyle,  // 🔹 opcional
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 36, color: theme.primaryColor),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: titleStyle ?? Theme.of(context).textTheme.titleLarge, // 🔹 usa titleLarge por defecto
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: subtitleStyle ?? Theme.of(context).textTheme.bodyMedium, // 🔹 bodyMedium por defecto
                      ),
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
                if (trailing == null) const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
            if (secondaryButton != null) ...[
              const SizedBox(height: 12),
              Align(alignment: Alignment.centerRight, child: secondaryButton!),
            ]
          ],
        ),
      ),
    );
  }
}
