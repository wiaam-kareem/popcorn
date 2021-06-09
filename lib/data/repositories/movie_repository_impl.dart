import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:popcorn/data/data_sources/movie_local_data_source.dart';
import 'package:popcorn/data/data_sources/movie_remote_data_source.dart';
import 'package:popcorn/data/models/cast_crew_model.dart';
import 'package:popcorn/data/models/movie_model.dart';
import 'package:popcorn/data/models/video_model.dart';
import 'package:popcorn/data/tables/movie_table.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/cast_entity.dart';
import 'package:popcorn/domain/entities/movie_detail_entity.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';
import 'package:popcorn/domain/entities/video_entity.dart';
import 'package:popcorn/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource _remoteDataSource;
  final MovieLocalDataSource _localDataSource;

  MovieRepositoryImpl(this._remoteDataSource,this._localDataSource);
  @override
  Future<Either<AppError, List<MovieModel>>> getTrending() async {
    try {
      final movies = await _remoteDataSource.getTrending();
      return Right(movies);
    } on SocketException {
      return left(AppError(AppErrorType.network));
    }on Exception{
      return left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getComingSoon() async {
    try {
      final movies = await _remoteDataSource.getComingSoon();
      return Right(movies);
    } on SocketException {
      return left(AppError(AppErrorType.network));
    }on Exception{
      return left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPopular() async {
    try {
      final movies = await _remoteDataSource.getPupular();
      return Right(movies);
     } on SocketException {
      return left(AppError(AppErrorType.network));
    }on Exception{
      return left(AppError(AppErrorType.api));
    }
  }
  @override
  Future<Either<AppError, List<MovieEntity>>> geyPlayingNow() async {
    try {
      final movies = await _remoteDataSource.getPlayingNow();
      return Right(movies);
   } on SocketException {
      return left(AppError(AppErrorType.network));
    }on Exception{
      return left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, MovieDetailEntity>> geyMovieDetail(int id) async {
  try {
      final movie = await _remoteDataSource.getMovieDetail(id);
      return Right(movie);
   } on SocketException {
      return left(AppError(AppErrorType.network));
    }on Exception{
      return left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<CastModel>>> geyCastCrew(int id)async {
      try {
      final crew = await _remoteDataSource.getCastCrew(id);
      return Right(crew);
   } on SocketException {
      return left(AppError(AppErrorType.network));
    }on Exception{
      return left(AppError(AppErrorType.api));
    }
    
  }

  @override
  Future<Either<AppError, List<VideoModel>>> getVideos(int id)async {
        try {
      final videos = await _remoteDataSource.getVideos(id);
      return Right(videos);
   } on SocketException {
      return left(AppError(AppErrorType.network));
    }on Exception{
      return left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getSearchMovie(String searchTerm)async {
        try {
      final movies = await _remoteDataSource.getSearchMovie(searchTerm);
      return Right(movies);
   } on SocketException {
      return left(AppError(AppErrorType.network));
    }on Exception{
      return left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> checkIfMovieFavorite(int movieId) async{
       try {
    final response=await _localDataSource.checkIfFavoriteMovie(movieId);
      return Right(response);

    }on Exception{
      return left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> deleteFavoriteMovie(int movieId)async {
        try {
    final response=await _localDataSource.deleteFavoriteMovie(movieId);
      return Right(response);

    }on Exception{
      return left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getFavoriteMovies() async{
      try {
    final response=await _localDataSource.getFavfetchFavorites();
      return Right(response);

    }on Exception{
      return left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> saveFavoriteMovie(MovieEntity movieEntity) async{
     try {
    final response=await _localDataSource.saveFavoriteMovie(MovieTable.fromMovieEntity(movieEntity));
      return Right(response);

    }on Exception{
      return left(AppError(AppErrorType.database));
    }
  }
}
