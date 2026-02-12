class MovieDetailEntity {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final String releaseDate;
  final int runtime;
  final String status;
  final String tagline;
  final List<GenreEntity> genres;

  MovieDetailEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.genres,
  });
}

class GenreEntity {
  final int id;
  final String name;

  GenreEntity({required this.id, required this.name});
}
