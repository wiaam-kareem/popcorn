import 'package:dartz/dartz.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';
import 'package:popcorn/domain/entities/movie_search_params.dart';
import 'package:popcorn/domain/repositories/movie_repository.dart';
import 'package:popcorn/domain/usecases/use_case.dart';

class GetSearchMovie  extends UseCase<List<MovieEntity>,MovieSearchParams>  {
  final MovieRepository _repository;

  GetSearchMovie(this._repository);
  @override
  Future<Either<AppError,List<MovieEntity>>>call(MovieSearchParams searchParam) async {
    return await _repository.getSearchMovie(searchParam.searchTerm);
  }
}
