class SerieEntity {
  final String name;
  final double averageScore;
  final String poster;
  final String releaseDate;

  const SerieEntity({
    this.name = '',
    this.averageScore = 0.0,
    this.poster = '',
    this.releaseDate = '',
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SerieEntity &&
        other.name == name &&
        other.averageScore == averageScore &&
        other.poster == poster &&
        other.releaseDate == releaseDate;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        averageScore.hashCode ^
        poster.hashCode ^
        releaseDate.hashCode;
  }
}
