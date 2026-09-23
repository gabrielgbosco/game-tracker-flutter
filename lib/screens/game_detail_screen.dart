import 'package:flutter/material.dart';

import '../models/game.dart';
import '../theme/app_theme.dart';

/// Tela de detalhes de um jogo. Permite alterar as horas jogadas e a
/// avaliação; as alterações são refletidas imediatamente na interface
/// através de [setState], e permanecem no objeto [Game] compartilhado
/// enquanto o aplicativo estiver em execução.
class GameDetailScreen extends StatefulWidget {
  final Game game;

  const GameDetailScreen({super.key, required this.game});

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  late Game _game;

  @override
  void initState() {
    super.initState();
    _game = widget.game;
  }

  void _addHours() => setState(() => _game.addHours());
  void _removeHours() => setState(() => _game.removeHours());
  void _increaseRating() => setState(() => _game.increaseRating());
  void _decreaseRating() => setState(() => _game.decreaseRating());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_game.name)),
      body: ListView(
        children: [
          ClipRRect(
            child: Image.asset(
              _game.imagePath,
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_game.name, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  children: [
                    _Tag(text: _game.genre),
                    _Tag(text: _game.platform),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  _game.description,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 28),
                _CounterCard(
                  icon: Icons.schedule_rounded,
                  label: 'Horas jogadas',
                  value: '${_game.hoursPlayed}h',
                  onIncrement: _addHours,
                  onDecrement: _removeHours,
                ),
                const SizedBox(height: 16),
                _CounterCard(
                  icon: Icons.star_rounded,
                  label: 'Avaliação',
                  value: _game.rating.toStringAsFixed(1),
                  onIncrement: _increaseRating,
                  onDecrement: _decreaseRating,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;

  const _Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: AppTheme.primary, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _CounterCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _CounterCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.accent),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDecrement,
            icon: const Icon(Icons.remove_circle_outline, color: AppTheme.textPrimary),
            tooltip: 'Diminuir',
          ),
          IconButton(
            onPressed: onIncrement,
            icon: const Icon(Icons.add_circle_outline, color: AppTheme.accent),
            tooltip: 'Aumentar',
          ),
        ],
      ),
    );
  }
}
