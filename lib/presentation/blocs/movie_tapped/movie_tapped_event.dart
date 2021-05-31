part of 'movie_tapped_bloc.dart';

abstract class MovieTappedEvent extends Equatable {
  const MovieTappedEvent();

  @override
  List<Object> get props => [];
}
class MovieTappedChangedEvent extends MovieTappedEvent{
  final int currentTappedIndex;
  const MovieTappedChangedEvent({this.currentTappedIndex=0});
    @override
  List<Object> get props => [currentTappedIndex];
}
