import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/common/constants/size_constants.dart';
import 'package:popcorn/common/screen_utilities/screen_util.dart';
import 'package:popcorn/data/core/api_constants.dart';
import 'package:popcorn/presentation/blocs/carousel_backdrop/carousel_backdrop_bloc.dart';
import 'package:popcorn/common/extensions/size_extension.dart';

class CarouselBackdropWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: 0.6,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(Sizes.dimen_40.w),
        ),
        child: Stack(
          children: <Widget>[
            FractionallySizedBox(
              heightFactor: 1,
              widthFactor: 1,
              child: BlocBuilder<CarouselBackdropBloc, CarouselBackdropState>(
                builder: (context, state) {
                  if (state is CarouselBackdropChanged) {
                    return CachedNetworkImage(
                      imageUrl:
                          '${ApiConstants.BASE_IMAGE_URL}${state.movie.backdropPath}',
                      fit: BoxFit.fitHeight,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                width: ScreenUtil.screenWidth,
                height: 1,
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}