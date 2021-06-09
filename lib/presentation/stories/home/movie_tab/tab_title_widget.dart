import 'package:flutter/material.dart';
import 'package:popcorn/common/constants/size_constants.dart';
import 'package:popcorn/presentation/app_localizations.dart';
import 'package:popcorn/presentation/themes/theme_color.dart';
import 'package:popcorn/presentation/themes/theme_text.dart';
import 'package:popcorn/common/extensions/size_extension.dart';
import 'package:popcorn/common/extensions/string_extension.dart';

class TabTitleWidget extends StatelessWidget {
  final String title;
  final Function() onTab;
  final bool isSellected;

  const TabTitleWidget({Key? key,
  required  this.title,
  required  this.onTab,
   this.isSellected=false}) :
   assert(title !=null,'title should not be null'),
   assert(onTab !=null,'onTab should not be null'),

    super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
          child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: isSellected?AppColor.royalBlue:Colors.transparent,
              width: Sizes.dimen_1.w,
            )
          )
        ),
        child: Text(
          title.t(context),
          style: isSellected?Theme.of(context).textTheme.royalBlueSubtitle1:
          Theme.of(context).textTheme.subtitle1,

          
        ),
      ),
    );
  }
}