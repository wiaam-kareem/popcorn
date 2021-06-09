import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/common/constants/size_constants.dart';
import 'package:popcorn/presentation/blocs/loading/loading_bloc.dart';
import 'package:popcorn/presentation/stories/loading/loading_citcle.dart';
import 'package:popcorn/common/extensions/size_extension.dart';
import 'package:popcorn/presentation/themes/theme_color.dart';

class LoadingScreen extends StatelessWidget {
  final Widget screen;
  const LoadingScreen({Key? key, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(body: Text('what happend',),);
    return BlocBuilder<LoadingBloc, LoadingState>(
      builder: (context, state) {
        print(state);
    
        return Stack(
          fit: StackFit.expand,
          children: [
            screen ,
            if (state is LoadingStarted)
              Container(
                decoration:
                    BoxDecoration(color: AppColor.vulcan.withOpacity(0.8)),
                child: Center(
                  child: LoadingCircle(
                    size: Sizes.dimen_200.w,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
