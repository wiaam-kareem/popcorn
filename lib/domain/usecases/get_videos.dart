import 'package:dartz/dartz.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';
import 'package:popcorn/domain/entities/movie_params.dart';
import 'package:popcorn/domain/entities/video_entity.dart';
import 'package:popcorn/domain/repositories/movie_repository.dart';
import 'package:popcorn/domain/usecases/use_case.dart';

class GetVideos  extends UseCase<List<VideoEntity>,MovieParams>  {
  final MovieRepository _repository;

  GetVideos(this._repository);
  @override
  Future<Either<AppError,List<VideoEntity>>>call(MovieParams movieParams) async {
    return await _repository.getVideos(movieParams.id);
  }
}
