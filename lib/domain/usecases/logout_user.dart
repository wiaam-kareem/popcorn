import 'package:dartz/dartz.dart';
import 'package:popcorn/domain/usecases/use_case.dart';

import '../entities/app_error.dart';
import '../entities/no_params.dart';
import '../repositories/authentication_repository.dart';


class LogoutUser extends UseCase<void, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  LogoutUser(this._authenticationRepository);

  @override
  Future<Either<AppError, void>> call(NoParams noParams) async =>
      _authenticationRepository.logoutUser();
}