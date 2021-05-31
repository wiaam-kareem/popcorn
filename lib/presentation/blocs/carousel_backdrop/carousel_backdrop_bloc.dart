import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';

part 'carousel_backdrop_event.dart';
part 'carousel_backdrop_state.dart';

class CarouselBackdropBloc extends Bloc<CarouselBackdropEvent, CarouselBackdropState> {
  CarouselBackdropBloc() : super(CarouselBackdropInitial());

  @override
  Stream<CarouselBackdropState> mapEventToState(
    CarouselBackdropEvent event,
  ) async* {
     yield CarouselBackdropChanged((event as CarouselBackdropChangedEvent).movie);
  }
}
