import 'package:dartz/dartz.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';
import 'package:popcorn/domain/repositories/app_repository.dart';
import 'package:popcorn/domain/repositories/movie_repository.dart';
import 'package:popcorn/domain/usecases/use_case.dart';

class UpdateLanguage  extends UseCase<void,String>  {
  final AppRepository _repository;

  UpdateLanguage(this._repository);
  @override
  Future<Either<AppError,void>>call(String languageCode) async {
   return   await _repository.updateLanguage(languageCode);
  }
}