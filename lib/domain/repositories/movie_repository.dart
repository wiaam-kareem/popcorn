import 'package:dartz/dartz.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/cast_entity.dart';
import 'package:popcorn/domain/entities/movie_detail_entity.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';
import 'package:popcorn/domain/entities/video_entity.dart';

abstract class MovieRepository {
  Future<Either<AppError,List<MovieEntity>>> getTrending();
  Future<Either<AppError,List<MovieEntity>>> getPopular();
  Future<Either<AppError,List<MovieEntity>>> getComingSoon();
  Future<Either<AppError,List<MovieEntity>>> geyPlayingNow();
  Future<Either<AppError,MovieDetailEntity>> geyMovieDetail(int id);
  Future<Either<AppError,List<CastEntity>>> geyCastCrew(int id);
  Future<Either<AppError,List<VideoEntity>>> getVideos(int id);
  Future<Either<AppError,List<MovieEntity>>> getSearchMovie(String searchTerm);
  Future<Either<AppError,void>> saveFavoriteMovie(MovieEntity movie);
  Future<Either<AppError,void>>deleteFavoriteMovie(int movieId);
  Future<Either<AppError,List<MovieEntity>>>getFavoriteMovies();
  Future<Either<AppError,bool>>checkIfMovieFavorite(int movieId);

}