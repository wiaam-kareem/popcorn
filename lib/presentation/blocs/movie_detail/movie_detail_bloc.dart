import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/movie_detail_entity.dart';
import 'package:popcorn/domain/entities/movie_params.dart';
import 'package:popcorn/domain/usecases/get_movie_detail.dart';
import 'package:popcorn/presentation/blocs/cast/cast_bloc.dart';
import 'package:popcorn/presentation/blocs/favorite_movie/favorite_movie_bloc.dart';
import 'package:popcorn/presentation/blocs/loading/loading_bloc.dart';
import 'package:popcorn/presentation/blocs/videos/videos_bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final CastBloc castBloc;
  final VideosBloc videosBloc;
  final FavoriteMovieBloc favoriteMovieBloc;
  final LoadingBloc loadingBloc;


  MovieDetailBloc({
    required this.videosBloc,
    required this.castBloc,
    required this.getMovieDetail,
    required this.favoriteMovieBloc,
    required this.loadingBloc,
  }) : super(MovieDetailInitial());

  @override
  Stream<MovieDetailState> mapEventToState(
    MovieDetailEvent event,
  ) async* {
    if (event is MovieDetailLoadEvent) {
     yield MovieDetailLoading();
  // await Future.delayed(Duration(milliseconds: 5000));
      final Either<AppError, MovieDetailEntity> eitherResponse =
          await getMovieDetail(
        MovieParams(id:event.movieId),
      );

      yield eitherResponse.fold(
        (l) => MovieDetailError(),
        (r) => MovieDetailLoaded(r),
      );
     favoriteMovieBloc.add(CheckIfFavoriteMovieEvent(movieId: event.movieId));
     castBloc.add(LoadCastEvent(movieId: event.movieId));
     videosBloc.add(LoadVideoEvent(videoId: event.movieId));
     
    }
  }
}