class MovieEntity {
  final String title;
  final double averageScore;
  final String poster;
  final String releaseDate;

  const MovieEntity({
    this.title = '',
    this.averageScore = 0.0,
    this.poster = '',
    this.releaseDate = '',
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieEntity &&
        other.title == title &&
        other.averageScore == averageScore &&
        other.poster == poster &&
        other.releaseDate == releaseDate;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        averageScore.hashCode ^
        poster.hashCode ^
        releaseDate.hashCode;
  }
}
