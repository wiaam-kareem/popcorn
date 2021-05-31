import 'package:flutter/material.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';
import 'package:popcorn/presentation/stories/home/movie_carousel/carousel_backdrop_Widget.dart';
import 'package:popcorn/presentation/stories/home/movie_carousel/movie_data_widget.dart';
import 'package:popcorn/presentation/stories/home/movie_carousel/movie_page_view.dart';
import 'package:popcorn/presentation/widgets/app_bar.dart';
import 'package:popcorn/presentation/widgets/seperator.dart';

class MovieCarouselWidget extends StatelessWidget {
  final List<MovieEntity>movies;
  final int defaultIndex;

  const MovieCarouselWidget({Key key, this.movies, this.defaultIndex}) :
  assert(defaultIndex >0,'defaultIndex should be greater than 0'),
   super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Stack(
    fit: StackFit.expand,  
      children: [
           CarouselBackdropWidget(),
      Column(
        children: [
            MyAppBar(),
        MoviePageView(
          movies:movies,
          initialPage:defaultIndex,
        ),
          MovieDataWidget(),
          Separator(),
        ],
      ),
      
      ],
    
    );
  }
}