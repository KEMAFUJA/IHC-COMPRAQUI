import 'package:flutter/material.dart';
import '../paleta.dart';
import 'package:provider/provider.dart';

class BotonPrimario extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final Color? color;
  final bool outlined;

  const BotonPrimario({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
    this.color,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context); // <--- obtenemos instancia

    return SizedBox(
      width: width ?? double.infinity,
      child: outlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: color ?? theme.primaryColor,
                side: BorderSide(color: color ?? theme.primaryColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: Text(label),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color ?? theme.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: Text(
                label,
                style: const TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}
