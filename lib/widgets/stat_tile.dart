import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Widget reutilizável para exibir um valor calculado (ex.: total de
/// jogos, total de horas, média de avaliação) em formato de cartão
/// pequeno, usado no Dashboard e na tela de Estatísticas.
class StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const StatTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.accent),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
