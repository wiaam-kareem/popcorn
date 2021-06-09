import 'package:flutter/material.dart';

import '../../../common/constants/size_constants.dart';
import '../../../common/extensions/size_extension.dart';
import '../../widgets/logo.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_32.h),
              child: Logo(
              
                height: Sizes.dimen_20,

              ),
            ),
            Expanded(
              child: LoginForm(
              
              ),
            ),
          ],
        ),
      ),
    );
  }
}