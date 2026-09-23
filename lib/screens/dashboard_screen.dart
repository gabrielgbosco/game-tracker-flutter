import 'package:flutter/material.dart';

import '../data/game_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_tile.dart';
import 'game_list_screen.dart';
import 'statistics_screen.dart';
import 'random_pick_screen.dart';

/// Tela inicial do aplicativo. Mostra um resumo da coleção (total de
/// jogos, total de horas jogadas e média das avaliações) e dá acesso
/// às demais telas.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GameRepository _repository = GameRepository.instance;

  /// Navega para outra tela e, ao retornar, atualiza o estado local
  /// para que os totais exibidos reflitam eventuais alterações feitas
  /// pelo usuário (ex.: horas ou avaliação de um jogo).
  Future<void> _navigateTo(Widget screen) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                const Icon(Icons.videogame_asset_rounded,
                    color: AppTheme.primary, size: 32),
                const SizedBox(width: 10),
                Text(
                  'Game Tracker',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Sua coleção de jogos, em um só lugar.',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                StatTile(
                  icon: Icons.collections_bookmark_rounded,
                  label: 'Jogos cadastrados',
                  value: '${_repository.totalGames}',
                ),
                StatTile(
                  icon: Icons.schedule_rounded,
                  label: 'Horas jogadas (total)',
                  value: '${_repository.totalHours}h',
                ),
                StatTile(
                  icon: Icons.star_rounded,
                  label: 'Média das avaliações',
                  value: _repository.averageRating.toStringAsFixed(1),
                ),
                StatTile(
                  icon: Icons.casino_rounded,
                  label: 'Indeciso?',
                  value: 'Sorteie',
                ),
              ],
            ),
            const SizedBox(height: 28),
            _MenuButton(
              icon: Icons.list_alt_rounded,
              title: 'Lista de jogos',
              subtitle: 'Veja todos os jogos da sua coleção',
              onTap: () => _navigateTo(const GameListScreen()),
            ),
            const SizedBox(height: 12),
            _MenuButton(
              icon: Icons.bar_chart_rounded,
              title: 'Estatísticas',
              subtitle: 'Gráficos e números da sua coleção',
              onTap: () => _navigateTo(const StatisticsScreen()),
            ),
            const SizedBox(height: 12),
            _MenuButton(
              icon: Icons.shuffle_rounded,
              title: 'O que jogar?',
              subtitle: 'Deixe o app escolher por você',
              onTap: () => _navigateTo(const RandomPickScreen()),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppTheme.primary.withOpacity(0.2),
                child: Icon(icon, color: AppTheme.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: const TextStyle(
                            color: AppTheme.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
