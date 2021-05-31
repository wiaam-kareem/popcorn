
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/presentation/blocs/carousel_backdrop/carousel_backdrop_bloc.dart';

class MovieDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselBackdropBloc, CarouselBackdropState>(
      builder: (context, state) {
        if (state is CarouselBackdropChanged) {
          return Text(
            state.movie.title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.headline6,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}