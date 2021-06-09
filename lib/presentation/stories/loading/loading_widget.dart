import 'package:flutter/material.dart';
import 'package:popcorn/presentation/blocs/theme/theme_cubit.dart';
import 'package:popcorn/presentation/stories/loading/loading_citcle.dart';
import 'package:popcorn/presentation/themes/theme_color.dart';
import 'package:provider/provider.dart';


class LoadingWidget extends StatelessWidget {
  final double size;
  const LoadingWidget({ Key? key,required  this.size }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return        Container(
                decoration:
                    BoxDecoration(color:  context.read<ThemeCubit>().state == Themes.dark
          ? AppColor.vulcan
          : Colors.white,),
                child: Center(
                  child: LoadingCircle(
                    size: size,
                  ),
                ),
              );
  }
}