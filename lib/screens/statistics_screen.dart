import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../data/game_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_tile.dart';
import '../widgets/section_title.dart';

/// Tela de estatísticas. Exibe um gráfico de barras com as horas
/// jogadas por jogo, além de informações calculadas a partir dos
/// dados reais da coleção (jogo mais jogado, melhor avaliado, total
/// de horas e média das avaliações).
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = GameRepository.instance;
    final games = repository.games;
    final maxHours = games
        .map((g) => g.hoursPlayed)
        .reduce((a, b) => a > b ? a : b)
        .toDouble();

    return Scaffold(
      appBar: AppBar(title: const Text('Estatísticas')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const SectionTitle('Horas jogadas por jogo'),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.fromLTRB(8, 20, 16, 12),
            height: 260,
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: BarChart(
              BarChartData(
                maxY: maxHours * 1.25,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => AppTheme.background,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final game = games[group.x.toInt()];
                      return BarTooltipItem(
                        '${game.name}\n${game.hoursPlayed}h',
                        const TextStyle(color: AppTheme.textPrimary, fontSize: 12),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= games.length) {
                          return const SizedBox.shrink();
                        }
                        final initials = games[index].name.length >= 3
                            ? games[index].name.substring(0, 3)
                            : games[index].name;
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            initials,
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: [
                  for (int i = 0; i < games.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: games[i].hoursPlayed.toDouble(),
                          color: AppTheme.primary,
                          width: 22,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          const SectionTitle('Resumo da coleção'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: [
                StatTile(
                  icon: Icons.emoji_events_rounded,
                  label: 'Mais jogado: ${repository.mostPlayedGame.name}',
                  value: '${repository.mostPlayedGame.hoursPlayed}h',
                ),
                StatTile(
                  icon: Icons.star_rounded,
                  label: 'Melhor avaliado: ${repository.bestRatedGame.name}',
                  value: repository.bestRatedGame.rating.toStringAsFixed(1),
                ),
                StatTile(
                  icon: Icons.schedule_rounded,
                  label: 'Total de horas jogadas',
                  value: '${repository.totalHours}h',
                ),
                StatTile(
                  icon: Icons.bar_chart_rounded,
                  label: 'Média geral das avaliações',
                  value: repository.averageRating.toStringAsFixed(1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
