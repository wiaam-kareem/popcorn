part of 'carousel_backdrop_bloc.dart';

abstract class CarouselBackdropEvent extends Equatable {
  const CarouselBackdropEvent();

  @override
  List<Object> get props => [];
}
class CarouselBackdropChangedEvent extends CarouselBackdropEvent{
  final MovieEntity movie;

  const CarouselBackdropChangedEvent(this.movie);
   @override
  List<Object> get props => [movie];


}
