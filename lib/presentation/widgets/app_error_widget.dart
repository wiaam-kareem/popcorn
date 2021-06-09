

import 'package:flutter/material.dart';
import 'package:popcorn/common/constants/size_constants.dart';
import 'package:popcorn/common/constants/translation_constants.dart';
import 'package:popcorn/common/extensions/size_extension.dart';
import 'package:popcorn/common/extensions/string_extension.dart';
import 'package:popcorn/domain/entities/app_error.dart';

import 'my_buttton.dart';




class AppErrorWidget extends StatelessWidget {
  final AppErrorType errorType;
  final Function onPressed;

  const AppErrorWidget({
    Key? key,
    required this.errorType,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return //7
        Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
            //1
            child: Column(
              //6
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //2
                Text(
                  errorType == AppErrorType.api
                      ? TranslationConstants.somethingWentWrong.t(context)
                      : TranslationConstants.checkNetwork.t(context),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                //3
                ButtonBar(
                  children: [
                    //4
                    Button(
                      onPressed:()=> onPressed,
                      text: TranslationConstants.retry,
                    ),
                    //5
              
                  ],
                ),
              ],
            ),
          );
        }
      }
      
