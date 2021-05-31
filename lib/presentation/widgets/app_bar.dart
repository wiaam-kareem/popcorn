import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popcorn/common/constants/size_constants.dart';
import 'package:popcorn/common/screen_utilities/screen_util.dart';
import 'package:popcorn/common/extensions/size_extension.dart';

import 'logo.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
        left: Sizes.dimen_16.w,
        right: Sizes.dimen_16.w,
      ),
      child: Row(
        children: [
          IconButton(
              icon: SvgPicture.asset(
                'assets/svgs/menu.svg',
                height: Sizes.dimen_12.h,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
              Expanded(child: Logo(height: Sizes.dimen_12,)),
          IconButton(
              icon: Icon(
                Icons.search,
                size: Sizes.dimen_12.h,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }
}
