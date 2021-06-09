part of 'movie_tapped_bloc.dart';

abstract class MovieTappedState extends Equatable {
  final int currentTappedIndex;
  const MovieTappedState({ this.currentTappedIndex=0});
  
  @override
  List<Object> get props => [currentTappedIndex];
}

class MovieTappedInitial extends MovieTappedState {}
class MovieTappedLoading extends MovieTappedState {
    const MovieTappedLoading({int currentTabIndex = 0})
      : super(currentTappedIndex: currentTabIndex);
}
class MovieTappedChanged extends MovieTappedState {
  final List<MovieEntity>movies;

const   MovieTappedChanged({required int currentIndex,required this.movies}):super(currentTappedIndex: currentIndex);
 @override
  List<Object> get props => [currentTappedIndex,movies];
}

class MovieTabLoadError extends MovieTappedState {
  final AppErrorType errorType;

  const MovieTabLoadError({
  required   int currentTabIndex,
    required this.errorType,
  }) : super(currentTappedIndex: currentTabIndex);
}
