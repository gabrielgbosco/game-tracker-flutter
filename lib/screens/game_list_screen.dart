import 'package:flutter/material.dart';

import '../data/game_repository.dart';
import '../widgets/game_card.dart';
import 'game_detail_screen.dart';

/// Tela que lista todos os jogos cadastrados na coleção.
class GameListScreen extends StatefulWidget {
  const GameListScreen({super.key});

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  final GameRepository _repository = GameRepository.instance;

  Future<void> _openDetails(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameDetailScreen(game: _repository.games[index]),
      ),
    );
    // Atualiza a tela ao voltar, pois horas/avaliação podem ter mudado.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final games = _repository.games;
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de jogos')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return GameCard(
            game: game,
            onTap: () => _openDetails(index),
          );
        },
      ),
    );
  }
}
