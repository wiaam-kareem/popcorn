import 'package:dartz/dartz.dart';
import 'package:popcorn/domain/entities/app_error.dart';

abstract class AppRepository {
  Future<Either<AppError, void>> updateLanguage(String language);

  Future<Either<AppError, String?>> getPreferedLanguage();
  Future<Either<AppError, void>> updateTheme(String theme);
  Future<Either<AppError, String>> getPreferredTheme();
}
