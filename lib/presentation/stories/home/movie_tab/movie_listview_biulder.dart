import 'package:flutter/material.dart';
import 'package:popcorn/common/constants/size_constants.dart';
import 'package:popcorn/common/extensions/size_extension.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';
import 'package:popcorn/presentation/stories/home/movie_carousel/movie_card_widget.dart';
import 'package:popcorn/presentation/stories/home/movie_tab/movie_tab_card_widget.dart';

class MovieListView extends StatelessWidget {
  final List<MovieEntity>movies;

  const MovieListView({Key? key,required this.movies}) :super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:Sizes.dimen_6.h),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          final MovieEntity movie=movies[index];
          return MovieTabCard(
            title: movie.title,
            
            movieId:movie.id ,
            posterPath: movie.posterPath,);
        },
      separatorBuilder: (context,index){return SizedBox(width: Sizes.dimen_14.w);},

      itemCount: movies.length)
      
    );
  }
}