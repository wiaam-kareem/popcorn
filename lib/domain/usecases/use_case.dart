import 'package:dartz/dartz.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';

abstract class UseCase<Type,Params>{

  Future<Either<AppError,Type>> call(Params params);
}