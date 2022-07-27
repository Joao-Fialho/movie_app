class AllEntity {
  final String title;
  final double averageScore;
  final String poster;
  final String mediaType;
  final String releaseDate;

  const AllEntity({
    this.title = '',
    this.averageScore = 0.0,
    this.poster = '',
    this.mediaType = '',
    this.releaseDate = '',
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AllEntity &&
        other.title == title &&
        other.averageScore == averageScore &&
        other.poster == poster &&
        other.mediaType == mediaType &&
        other.releaseDate == releaseDate;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        averageScore.hashCode ^
        poster.hashCode ^
        mediaType.hashCode ^
        releaseDate.hashCode;
  }
}
