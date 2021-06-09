import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/presentation/blocs/login_cubit/login_cubit_cubit.dart';
import 'package:popcorn/presentation/stories/loading/loading_citcle.dart';
import 'package:popcorn/presentation/widgets/my_buttton.dart';

import '../../../common/constants/route_constants.dart';
import '../../../common/constants/size_constants.dart';
import '../../../common/constants/translation_constants.dart';
import '../../../common/extensions/size_extension.dart';
import '../../../common/extensions/string_extension.dart';
import '../../themes/theme_text.dart';
import 'label_field_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController? _userNameController, _passwordController;
  bool enableSignIn = false;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();

    _userNameController?.addListener(() {
      setState(() {
        enableSignIn = (_userNameController?.text.isNotEmpty ?? false) &&
            (_passwordController?.text.isNotEmpty ?? false);
      });
    });
    _passwordController?.addListener(() {
      setState(() {
        enableSignIn = (_userNameController?.text.isNotEmpty ?? false) &&
            (_passwordController?.text.isNotEmpty ?? false);
      });
    });
  }

  @override
  void dispose() {
    _userNameController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_32.w,
          vertical: Sizes.dimen_24.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: Sizes.dimen_8.h),
              child: Text(
                TranslationConstants.loginToMovieApp.t(context),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            LabelFieldWidget(
              label: TranslationConstants.username.t(context),
              hintText: TranslationConstants.enterTMDbUsername.t(context),
              controller: _userNameController!,
              textFieldKey: const ValueKey('username_text_field_key'),
            ),
            LabelFieldWidget(
              label: TranslationConstants.password.t(context),
              hintText: TranslationConstants.enterPassword.t(context),
              controller: _passwordController!,
              isPasswordField: true,
              textFieldKey: const ValueKey('password_text_field_key'),
            ),
            BlocConsumer<LoginCubit, LoginState>(
              buildWhen: (previous, current) => current is LoginError,
              builder: (context, state) {
                if (state is LoginError)
                  return Text(
                    state.message.t(context),
                    style: Theme.of(context).textTheme.orangeSubtitle1,
                  );
                return const SizedBox.shrink();
              },
              listenWhen: (previous, current) => current is LoginSuccess,
              listener: (context, state) {
                
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteList.home,
                  (route) => false,
                );
              },
            ),

             BlocBuilder<LoginCubit, LoginState>(
           
               builder: (context,state){
                 if(state is LoginLoading){
                   
         return   LoadingCircle(size:Sizes.dimen_100.h ,);
                 }else{
                   return   Button(
              onPressed: () => enableSignIn
                  ? BlocProvider.of<LoginCubit>(context).initiateLogin(
                      _userNameController?.text ?? '',
                      _passwordController?.text ?? '',
                    )
                  : null,
              text: TranslationConstants.signIn,
              isEnabled: enableSignIn,
            );
                 }
               }
               
               ,
             )

          ],
        ),
      ),
    );
  }
}