import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/common/constants/size_constants.dart';
import 'package:popcorn/common/extensions/size_extension.dart';
import 'package:popcorn/domain/entities/movie_detail_entity.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';
import 'package:popcorn/presentation/blocs/favorite_movie/favorite_movie_bloc.dart';

class MovieDetailAppBar extends StatelessWidget {
  final MovieDetailEntity movieDetailEntity;

  const MovieDetailAppBar({Key? key, required this.movieDetailEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: Sizes.dimen_12.h,
          ),
        ),
         BlocBuilder<FavoriteMovieBloc,FavoriteMovieState>(builder: (context,state){
            if(state is IsFavoriteMovieCheck){
           return    GestureDetector(
             onTap:()=>BlocProvider.of<FavoriteMovieBloc>(context).add(ToggleFavoriteMovieEvent(
               isFavorite:state.isFavorite,
               movieEntity: MovieEntity.fromMovieDetailEntity(movieDetailEntity) ,
             )) ,
             child: Icon(
             state.isFavorite?Icons.favorite:Icons.favorite_border,
              color: Colors.white,
              size: Sizes.dimen_12.h,
                     ),
           );
            }else{
           return    Icon(
            Icons.favorite_border,
            color: Colors.white,
            size: Sizes.dimen_12.h,
          );
            }
        
          }),
        
      ],
    );
  }
}