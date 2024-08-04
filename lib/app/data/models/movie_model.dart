import '../helpers/data.dart';

class MovieModel {
  final int id;
  final String title, backdropPath, posterPath;
  final List<int> genreIds;

  MovieModel({
    this.id = 0,
    this.title = '',
    this.backdropPath = '',
    this.posterPath = '',
    this.genreIds = const []
  });

  MovieModel.fromJson(Map<String, dynamic> json)
    : id = Data.toInt(json['id']),
      title = Data.toStr(json['title']),
      backdropPath = Data.toStr(json['backdrop_path']),
      posterPath = Data.toStr(json['poster_path']),
      genreIds = Data.toIntList(json['genre_ids']);
  
  static List<MovieModel> movieList(data) {
    final List<MovieModel> list = [];
    if (Data.isList(data)) {
      for (var v in data) {
        if (v is Map<String, dynamic>) {
          list.add(MovieModel.fromJson(v));
        }
      }
    }
    return list;
  }
}

class GenreModel {
  final int id; 
  final String name;

  GenreModel({
    this.id = 0,
    this.name = ''
  });

  GenreModel.fromJson(Map<String, dynamic> json)
    : id = Data.toInt(json['id']),
      name = Data.toStr(json['name']);
  
  static List<GenreModel> genreList(data) {
    final List<GenreModel> list = [];
    if (Data.isList(data)) {
      for (var v in data) {
        if (v is Map<String, dynamic>) {
          list.add(GenreModel.fromJson(v));
        }
      }
    }
    return list;
  }
}

class MovieDetailModel {
  final String backdropPath, title, overview, releaseDate;
  final List<GenreModel> genres;
  final double voteAverage;

  MovieDetailModel({
    this.backdropPath = '',
    this.title = '',
    this.overview = '',
    this.releaseDate = '',
    this.genres = const [],
    this.voteAverage = 0.0
  });

  MovieDetailModel.fromJson(Map<String, dynamic> json)
    : backdropPath = Data.toStr(json['backdrop_path']),
      title = Data.toStr(json['title']),
      overview = Data.toStr(json['overview']),
      releaseDate = Data.toStr(json['release_date']),
      genres = GenreModel.genreList(json['genres']),
      voteAverage = Data.toDouble(json['vote_average']);
}