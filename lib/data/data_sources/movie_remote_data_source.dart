import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:popcorn/data/core/api_client.dart';
import 'package:popcorn/data/core/api_constants.dart';
import 'package:popcorn/data/models/cast_crew_model.dart';
import 'package:popcorn/data/models/movie_detail_model.dart';
import 'package:popcorn/data/models/movie_model.dart';
import 'package:popcorn/data/models/movies_result_model.dart';
import 'package:popcorn/data/models/video_model.dart';
import 'package:popcorn/data/models/video_result_model.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();
  Future<List<MovieModel>> getPupular();
  Future<List<MovieModel>> getComingSoon();
  Future<List<MovieModel>> getPlayingNow();
  Future<MovieDetailModel>getMovieDetail(int id);
  Future<List<CastModel>>getCastCrew(int id);
  Future<List<VideoModel>> getVideos(int id);
  Future<List<MovieModel>>getSearchMovie(String searchTerm);
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending() async {
    final response = await _client.get('trending/movie/day');
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies;
  }

  @override
  Future<List<MovieModel>> getPupular() async {
    final response = await _client.get('movie/popular');
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies;
  }

  @override
  Future<List<MovieModel>> getPlayingNow() async{
     final response = await _client.get('movie/now_playing');
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies;
  }

  @override
  Future<List<MovieModel>> getComingSoon() async{
 final response = await _client.get('movie/upcoming');
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies;
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id)async {
    final response = await _client.get('movie/$id');
    final movie = MovieDetailModel.fromJson(response);
    print(movie);
    return movie;
  }

  @override
  Future<List<CastModel>> getCastCrew(int id)async {
    final response = await _client.get('movie/$id/credits');
    final cast = CastCrewResultModel.fromJson(response).cast;
    print(cast);
    return cast;
}

  @override
  Future<List<VideoModel>> getVideos(int id)async {
     final response = await _client.get('movie/$id/videos');
    final videos = VideoResultModel.fromJson(response).videos;
    print(videos);
    return videos;
  }

  @override
  Future<List<MovieModel>> getSearchMovie(String searchTerm) async{
  final response = await _client.get('search/movie',params: {
    'query':searchTerm,
  });
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies;
  }
}
