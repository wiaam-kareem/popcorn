part of 'carousel_backdrop_bloc.dart';

abstract class CarouselBackdropState extends Equatable {
  const CarouselBackdropState();
  
  @override
  List<Object> get props => [];
}

class CarouselBackdropInitial extends CarouselBackdropState {}
class CarouselBackdropChanged extends CarouselBackdropState {
  final MovieEntity movie;

 const CarouselBackdropChanged(this.movie);
  @override
  List<Object> get props => [movie];

}
