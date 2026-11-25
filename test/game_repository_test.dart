import 'package:flutter_test/flutter_test.dart';

import 'package:game_tracker/data/game_repository.dart';

void main() {
  group('GameRepository.weightedAverageRating', () {
    test('pondera as avaliações pelas horas jogadas', () {
      // Soma(avaliação x horas) = 1526,5 ; soma(horas) = 185 ; média = 8,2514.
      // A média simples seria 8,0833, então este teste falha se a regra mudar.
      final repository = GameRepository.instance;

      expect(repository.weightedAverageRating, closeTo(8.2514, 0.0001));
      expect(repository.weightedAverageRating,
          isNot(closeTo(repository.averageRating, 0.0001)));
    });

    test('retorna 0 quando nenhum jogo tem horas registradas', () {
      final repository = GameRepository.instance;
      final originalHours = [for (final g in repository.games) g.hoursPlayed];

      try {
        for (final g in repository.games) {
          g.hoursPlayed = 0;
        }
        expect(repository.weightedAverageRating, 0);
      } finally {
        for (var i = 0; i < repository.games.length; i++) {
          repository.games[i].hoursPlayed = originalHours[i];
        }
      }
    });
  });
}
