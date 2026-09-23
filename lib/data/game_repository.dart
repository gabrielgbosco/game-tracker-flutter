import 'dart:math';

import '../models/game.dart';

/// Fonte única de dados do aplicativo.
///
/// Mantém a coleção de jogos em memória durante a execução (sem banco
/// de dados, API externa ou serviços em nuvem, conforme as restrições
/// da atividade). Por ser um singleton, todas as telas enxergam a
/// mesma lista de objetos [Game]; como os campos mutáveis do modelo
/// são alterados por referência, qualquer tela que leia os dados
/// novamente (por exemplo, após um `Navigator.pop`) já reflete as
/// alterações feitas em outra tela.
class GameRepository {
  GameRepository._internal();

  static final GameRepository instance = GameRepository._internal();

  final List<Game> games = [
    Game(
      id: 'g1',
      name: 'Shadow Realms',
      imagePath: 'assets/images/shadow_realms.png',
      genre: 'RPG',
      platform: 'PC',
      description:
          'Um RPG de mundo aberto ambientado em um reino tomado pela '
          'escuridão. Explore ruínas antigas, recrute aliados e tome '
          'decisões que mudam o rumo da história.',
      hoursPlayed: 42,
      rating: 8.5,
    ),
    Game(
      id: 'g2',
      name: 'Star Voyager',
      imagePath: 'assets/images/star_voyager.png',
      genre: 'Ficção Científica',
      platform: 'PlayStation',
      description:
          'Comande sua própria nave em uma jornada pelo espaço profundo, '
          'negociando com colônias distantes e enfrentando piratas '
          'estelares.',
      hoursPlayed: 27,
      rating: 7.0,
    ),
    Game(
      id: 'g3',
      name: 'Kart Rush',
      imagePath: 'assets/images/kart_rush.png',
      genre: 'Corrida',
      platform: 'Switch',
      description:
          'Corridas frenéticas em kart com itens especiais e pistas '
          'cheias de atalhos. Ideal para partidas rápidas com amigos.',
      hoursPlayed: 15,
      rating: 9.0,
    ),
    Game(
      id: 'g4',
      name: 'Puzzle Grove',
      imagePath: 'assets/images/puzzle_grove.png',
      genre: 'Puzzle',
      platform: 'Mobile',
      description:
          'Quebra-cabeças relaxantes ambientados em uma floresta '
          'encantada, com centenas de fases e trilha sonora tranquila.',
      hoursPlayed: 8,
      rating: 6.5,
    ),
    Game(
      id: 'g5',
      name: 'Iron Legion',
      imagePath: 'assets/images/iron_legion.png',
      genre: 'Estratégia',
      platform: 'PC',
      description:
          'Jogo de estratégia em tempo real onde o jogador comanda '
          'exércitos mecanizados em batalhas táticas contra a IA ou '
          'outros comandantes.',
      hoursPlayed: 60,
      rating: 8.0,
    ),
    Game(
      id: 'g6',
      name: 'Blossom Farm',
      imagePath: 'assets/images/blossom_farm.png',
      genre: 'Simulação',
      platform: 'Switch',
      description:
          'Simulador de fazenda descontraído: plante, colha, cuide de '
          'animais e construa relações com os moradores da vila.',
      hoursPlayed: 33,
      rating: 9.5,
    ),
  ];

  int get totalGames => games.length;

  int get totalHours => games.fold(0, (sum, g) => sum + g.hoursPlayed);

  double get averageRating {
    if (games.isEmpty) return 0;
    final sum = games.fold(0.0, (s, g) => s + g.rating);
    return sum / games.length;
  }

  Game get mostPlayedGame =>
      games.reduce((a, b) => a.hoursPlayed >= b.hoursPlayed ? a : b);

  Game get bestRatedGame =>
      games.reduce((a, b) => a.rating >= b.rating ? a : b);

  /// Retorna um jogo aleatório da coleção, usado na funcionalidade
  /// "O que jogar?".
  Game randomGame() {
    final random = Random();
    return games[random.nextInt(games.length)];
  }

  /// Agrupa a quantidade de jogos por gênero, usado no gráfico de
  /// estatísticas.
  Map<String, int> countByGenre() {
    final map = <String, int>{};
    for (final game in games) {
      map[game.genre] = (map[game.genre] ?? 0) + 1;
    }
    return map;
  }
}
