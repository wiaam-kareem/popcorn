import 'package:dartz/dartz.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/movie_params.dart';
import 'package:popcorn/domain/repositories/movie_repository.dart';
import 'package:popcorn/domain/usecases/use_case.dart';

class CheckIfFavoriteMovie  extends UseCase<bool ,MovieParams>  {
  final MovieRepository _repository;

  CheckIfFavoriteMovie(this._repository);
  @override
  Future<Either<AppError,bool>>call(MovieParams movieParams) async {
   return   await _repository.checkIfMovieFavorite(movieParams.id);
  }
}