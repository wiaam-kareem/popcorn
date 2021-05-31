part of 'movie_tapped_bloc.dart';

abstract class MovieTappedState extends Equatable {
  final int currentTappedIndex;
  const MovieTappedState({this.currentTappedIndex});
  
  @override
  List<Object> get props => [currentTappedIndex];
}

class MovieTappedInitial extends MovieTappedState {}
class MovieTappedChanged extends MovieTappedState {
  final List<MovieEntity>movies;

const   MovieTappedChanged({int currentIndex,this.movies}):super(currentTappedIndex: currentIndex);
 @override
  List<Object> get props => [currentTappedIndex,movies];
}

class MovieTabLoadError extends MovieTappedState {
  final AppErrorType errorType;

  const MovieTabLoadError({
    int currentTabIndex,
    @required this.errorType,
  }) : super(currentTappedIndex: currentTabIndex);
}
