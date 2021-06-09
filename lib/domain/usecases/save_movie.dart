import 'package:dartz/dartz.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';
import 'package:popcorn/domain/repositories/movie_repository.dart';
import 'package:popcorn/domain/usecases/use_case.dart';

class SaveFavoriteMovie  extends UseCase<void,MovieEntity>  {
  final MovieRepository _repository;

  SaveFavoriteMovie(this._repository);
  @override
  Future<Either<AppError,void>>call(MovieEntity movieEntity) async {
   return   await _repository.saveFavoriteMovie(movieEntity);
  }
}