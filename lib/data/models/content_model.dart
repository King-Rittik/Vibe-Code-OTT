class ContentModel {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String backdropUrl;
  final String videoUrl;
  final String genre;
  final List<String> genres;
  final double rating;
  final int year;
  final String duration;
  final String contentType; // 'movie' | 'series' | 'documentary'
  final bool isFeatured;
  final bool isNew;
  final bool isTrending;
  final String ageRating;
  final List<String> cast;
  final String director;
  final String language;
  final int seasons; // for series
  final int episodes; // for series

  const ContentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.backdropUrl,
    required this.videoUrl,
    required this.genre,
    required this.genres,
    required this.rating,
    required this.year,
    required this.duration,
    required this.contentType,
    this.isFeatured = false,
    this.isNew = false,
    this.isTrending = false,
    this.ageRating = 'U/A 13+',
    this.cast = const [],
    this.director = '',
    this.language = 'English',
    this.seasons = 0,
    this.episodes = 0,
  });
}
