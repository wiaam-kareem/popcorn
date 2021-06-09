import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/login_request_params.dart';
import '../../../domain/entities/no_params.dart';
import '../../../domain/usecases/login_user.dart';
import '../../../domain/usecases/logout_user.dart';


part 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
 

  LoginCubit({
    required this.loginUser,
    required this.logoutUser,
   
  }) : super(LoginInitial());

  void initiateLogin(String username, String password) async {
  emit(LoginLoading());
    final Either<AppError, bool> eitherResponse = await loginUser(
      LoginRequestParams(
        userName: username,
        password: password,
      ),
    );

    emit(eitherResponse.fold(
      (l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return LoginError(message);
      },
      (r) => LoginSuccess(),
    ));
   
  }

  void logout({required BuildContext context}) async {
    await logoutUser(NoParams()).then((value) => Navigator.of(context,rootNavigator: true).pop());
    emit(LogoutSuccess());
  }

  String getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.network:
        return TranslationConstants.noNetwork;
      case AppErrorType.api:
      case AppErrorType.database:
        return TranslationConstants.somethingWentWrong;
      case AppErrorType.sessionDenied:
        return TranslationConstants.sessionDenied;
      default:
        return TranslationConstants.wrongUsernamePassword;
    }
  }
}