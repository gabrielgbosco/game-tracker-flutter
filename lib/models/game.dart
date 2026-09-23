/// Representa um jogo da coleção do usuário.
///
/// Os campos [hoursPlayed] e [rating] são mutáveis, pois podem ser
/// alterados pelo usuário durante a execução do aplicativo (estado
/// mantido apenas em memória, conforme exigido pela atividade).
class Game {
  final String id;
  final String name;
  final String imagePath;
  final String genre;
  final String platform;
  final String description;

  int hoursPlayed;
  double rating;

  Game({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.genre,
    required this.platform,
    required this.description,
    required this.hoursPlayed,
    required this.rating,
  });

  static const double minRating = 0;
  static const double maxRating = 10;
  static const double ratingStep = 0.5;
  static const int hoursStep = 1;

  /// Aumenta as horas jogadas.
  void addHours() {
    hoursPlayed += hoursStep;
  }

  /// Diminui as horas jogadas, nunca permitindo valores negativos.
  void removeHours() {
    hoursPlayed = (hoursPlayed - hoursStep).clamp(0, 1 << 30);
  }

  /// Aumenta a avaliação, respeitando o limite máximo.
  void increaseRating() {
    rating = (rating + ratingStep).clamp(minRating, maxRating);
  }

  /// Diminui a avaliação, respeitando o limite mínimo.
  void decreaseRating() {
    rating = (rating - ratingStep).clamp(minRating, maxRating);
  }
}
