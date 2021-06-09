import 'package:dartz/dartz.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/no_params.dart';
import 'package:popcorn/domain/repositories/app_repository.dart';
import 'package:popcorn/domain/usecases/use_case.dart';

class GetPreferedLanguage  extends UseCase<String?,NoParams>  {
  final AppRepository _repository;

  GetPreferedLanguage(this._repository);
  @override
  Future<Either<AppError,String?>>call(NoParams noParams) async {
   return   await _repository.getPreferedLanguage();
  }
}
