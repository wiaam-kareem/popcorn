
import 'package:popcorn/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
 final List<int> genreIds;
 final String originalLanguage;
 final String originalTitle;
 final String posterPath;
 final bool video;
 final double voteAverage;
 final String overview;
 final String releaseDate;
 final int voteCount;
 final String title;
 final bool adult;
 final String backdropPath;
 final int id;
 final double popularity;
 final String mediaType;

  MovieModel(
      {this.genreIds,
      this.originalLanguage,
      this.originalTitle,
      this.posterPath,
      this.video,
      this.voteAverage,
      this.overview,
      this.releaseDate,
      this.voteCount,
      this.title,
      this.adult,
      this.backdropPath,
      this.id,
      this.popularity,
      this.mediaType}):super(
        id: id,
        backdropPath: backdropPath,
        overview: overview,
        posterPath: posterPath,
        releaseDate: releaseDate,
        title: title,
        voteAverage: voteAverage,
        );

 factory MovieModel.fromJson(Map<String, dynamic> json) {
   return MovieModel(
    genreIds :json['genre_ids'].cast<int>(),
    originalLanguage : json['original_language'],
    originalTitle : json['original_title'],
    posterPath : json['poster_path'],
    video : json['video'],
    voteAverage : json['vote_average']?.toDouble()??0.0,
    overview : json['overview'],
    releaseDate : json['release_date'],
    voteCount : json['vote_count'],
    title : json['title'],
    adult : json['adult'],
    backdropPath : json['backdrop_path'],
    id : json['id'],
    popularity : json['popularity']?.toDouble()??0.0,
    mediaType : json['media_type'],
   );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['genre_ids'] = this.genreIds;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['poster_path'] = this.posterPath;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    data['vote_count'] = this.voteCount;
    data['title'] = this.title;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['id'] = this.id;
    data['popularity'] = this.popularity;
    data['media_type'] = this.mediaType;
    return data;
  }
}
