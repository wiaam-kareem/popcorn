
import 'package:dartz/dartz.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/movie_detail_entity.dart';
import 'package:popcorn/domain/entities/movie_params.dart';
import 'package:popcorn/domain/repositories/movie_repository.dart';
import 'package:popcorn/domain/usecases/use_case.dart';

class GetMovieDetail  extends UseCase<MovieDetailEntity,MovieParams>  {
  final MovieRepository _repository;

  GetMovieDetail(this._repository);
  @override
  Future<Either<AppError,MovieDetailEntity>>call(MovieParams movieParams) async {
    return await _repository.geyMovieDetail(movieParams.id);
  }
}