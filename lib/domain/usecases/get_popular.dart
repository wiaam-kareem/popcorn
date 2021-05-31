import 'package:dartz/dartz.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';
import 'package:popcorn/domain/entities/no_params.dart';
import 'package:popcorn/domain/repositories/movie_repository.dart';
import 'package:popcorn/domain/usecases/use_case.dart';

class GetPopular extends UseCase<List<MovieEntity>,NoParams> {
  final MovieRepository _repository;

  GetPopular(this._repository);

  @override
  Future<Either<AppError,List<MovieEntity>>>call(NoParams noParams) async {
    return await _repository.getPopular();
  }
}