import 'dart:async';


import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/domain/entities/app_error.dart';

import 'package:popcorn/domain/entities/movie_entity.dart';
import 'package:popcorn/domain/entities/no_params.dart';
import 'package:popcorn/domain/usecases/get_trending.dart';
import 'package:popcorn/presentation/blocs/carousel_backdrop/carousel_backdrop_bloc.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;
  final CarouselBackdropBloc carouselBackdropBloc;
  MovieCarouselBloc({ @required this.getTrending,@required this.carouselBackdropBloc}
   
  ) : super(MovieCarouselInitial());

  @override
  Stream<MovieCarouselState> mapEventToState(
    MovieCarouselEvent event,
  ) async* {
    if(event is CarouselLoadEvent){
      final movieEither= await getTrending(NoParams());
     yield movieEither.fold(
       
       (l) {
        
         return MovieCarouselError(l.appErrorType);},
       (moviesList){
         carouselBackdropBloc.add(CarouselBackdropChangedEvent(moviesList[event.defaultIndex]));
         return  MovieCarouselLoaded(movies: moviesList,defaultIndex: event.defaultIndex );
       });
    }
  }
}
