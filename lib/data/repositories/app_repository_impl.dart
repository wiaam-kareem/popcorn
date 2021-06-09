import 'package:dartz/dartz.dart';

import 'package:popcorn/data/data_sources/language_local_data_source.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/repositories/app_repository.dart';

class AppRepositoryImpl extends AppRepository {
  LanguageLocalDataSource languageLocalDataSource;
  AppRepositoryImpl({
    required this.languageLocalDataSource,
  });
  
  @override
  Future<Either<AppError, String?>> getPreferedLanguage() async{
       try {
    final response=await languageLocalDataSource.getPreferedLanguage();
      return Right(response);

    }on Exception{
      return left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> updateLanguage(String language) async{
      try {
    final response=await languageLocalDataSource.updateLanguage(language);
      return Right(response);

    }on Exception{
      return left(AppError(AppErrorType.database));
    }
  }

  
  @override
  Future<Either<AppError, String>> getPreferredTheme() async {
    try {
      final response = await languageLocalDataSource.getPreferredTheme();
      return Right(response);
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> updateTheme(String themeName) async {
    try {
      final response = await languageLocalDataSource.updateTheme(themeName);
      return Right(response);
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }


}
