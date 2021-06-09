import 'package:dartz/dartz.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/movie_params.dart';
import 'package:popcorn/domain/repositories/movie_repository.dart';
import 'package:popcorn/domain/usecases/use_case.dart';

class DeleteFavoriteMovie  extends UseCase<void,MovieParams>  {
  final MovieRepository _repository;

  DeleteFavoriteMovie(this._repository);
  @override
  Future<Either<AppError,void>>call(MovieParams params) async {
   return   await _repository.deleteFavoriteMovie(params.id);
  }
}