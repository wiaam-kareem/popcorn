part of 'favorite_movie_bloc.dart';

abstract class FavoriteMovieState extends Equatable {
  const FavoriteMovieState();

  @override
  List<Object> get props => [];
}

class FavoriteMovieInitial extends FavoriteMovieState {}

class FavoriteMoviesLoaded extends FavoriteMovieState {
  final List<MovieEntity> movies;

  FavoriteMoviesLoaded({required this.movies});
  
  @override
  List<Object> get props => [movies];
}

class IsFavoriteMovieCheck extends FavoriteMovieState {
  final bool isFavorite;

  IsFavoriteMovieCheck({required this.isFavorite});
  
  @override
  List<Object> get props => [isFavorite];
}
class FavoriteMovieError extends FavoriteMovieState {}
class FavoriteMovieLoading extends FavoriteMovieState {}
  
