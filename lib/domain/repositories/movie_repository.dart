import 'package:dartz/dartz.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/movie_detail_entity.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<AppError,List<MovieEntity>>> getTrending();
  Future<Either<AppError,List<MovieEntity>>> getPopular();
  Future<Either<AppError,List<MovieEntity>>> getComingSoon();
  Future<Either<AppError,List<MovieEntity>>> geyPlayingNow();
  Future<Either<AppError,MovieDetailEntity>> geyMovieDetail(int id);

}