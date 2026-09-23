import 'package:flutter/material.dart';

import '../data/game_repository.dart';
import '../models/game.dart';
import '../theme/app_theme.dart';

/// Tela "O que jogar?". Sorteia aleatoriamente um jogo da coleção
/// usando `dart:math` (através de [GameRepository.randomGame]) e
/// permite ao usuário sortear novamente.
class RandomPickScreen extends StatefulWidget {
  const RandomPickScreen({super.key});

  @override
  State<RandomPickScreen> createState() => _RandomPickScreenState();
}

class _RandomPickScreenState extends State<RandomPickScreen> {
  late Game _picked;

  @override
  void initState() {
    super.initState();
    _picked = GameRepository.instance.randomGame();
  }

  void _sortearNovamente() {
    setState(() {
      _picked = GameRepository.instance.randomGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('O que jogar?')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                _picked.imagePath,
                width: 220,
                height: 260,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _picked.name,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                _Chip(text: _picked.genre),
                _Chip(text: _picked.platform),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _sortearNovamente,
                icon: const Icon(Icons.shuffle_rounded),
                label: const Text('Sortear novamente'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;

  const _Chip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: AppTheme.textSecondary)),
    );
  }
}
