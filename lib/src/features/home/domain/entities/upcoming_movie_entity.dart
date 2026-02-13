class UpcomingMovieEntity {
   final int id;
  final String title;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  UpcomingMovieEntity({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });
}
