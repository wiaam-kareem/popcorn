import 'package:dartz/dartz.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/cast_entity.dart';
import 'package:popcorn/domain/entities/movie_params.dart';
import 'package:popcorn/domain/repositories/movie_repository.dart';
import 'package:popcorn/domain/usecases/use_case.dart';

class GetCastCrew  extends UseCase<List<CastEntity>,MovieParams>  {
  final MovieRepository _repository;

  GetCastCrew(this._repository);
  @override
  Future<Either<AppError,List<CastEntity>>>call(MovieParams movieParams) async {
    return await _repository.geyCastCrew(movieParams.id);
  }
}
