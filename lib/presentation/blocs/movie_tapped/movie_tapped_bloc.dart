import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';
import 'package:popcorn/domain/entities/no_params.dart';
import 'package:popcorn/domain/usecases/get_coming_soon.dart';
import 'package:popcorn/domain/usecases/get_playing_now.dart';
import 'package:popcorn/domain/usecases/get_popular.dart';

part 'movie_tapped_event.dart';
part 'movie_tapped_state.dart';

class MovieTappedBloc extends Bloc<MovieTappedEvent, MovieTappedState> {
  final GetPopular getPopular;
  final GetCommingSoon getCommingSoon;
  final GetPlayingNow getPlayingNow;

  MovieTappedBloc({this.getPopular, this.getCommingSoon, this.getPlayingNow}) : super(MovieTappedInitial());

  @override
  Stream<MovieTappedState> mapEventToState(
    MovieTappedEvent event,
  ) async* {
   if(event is MovieTappedChangedEvent){
     Either<AppError,List<MovieEntity>>moviesOrError;
     switch(event.currentTappedIndex){
       case 0:
       moviesOrError=await getPopular(NoParams());
       break;
        case 1:
       moviesOrError=await getCommingSoon(NoParams());
       break;
        case 2:
       moviesOrError=await getPlayingNow(NoParams());
       break;
     }
     yield moviesOrError.fold(
          (l) => MovieTabLoadError(
          currentTabIndex: event.currentTappedIndex,
          errorType: l.appErrorType,
        ),
      (movies) {
        return MovieTappedChanged(
          currentIndex: event.currentTappedIndex,
          movies:movies,
        );
      });
   }
  }
}
