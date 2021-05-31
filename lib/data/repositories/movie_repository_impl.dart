import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:popcorn/data/data_sources/movie_remote_data_source.dart';
import 'package:popcorn/data/models/movie_model.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/movie_detail_entity.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';
import 'package:popcorn/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource _remoteDataSource;

  MovieRepositoryImpl(this._remoteDataSource);
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
}
