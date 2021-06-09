part of 'favorite_movie_bloc.dart';

abstract class FavoriteMovieEvent extends Equatable {
  const FavoriteMovieEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoriteMoviesEvent extends FavoriteMovieEvent {}

class ToggleFavoriteMovieEvent extends FavoriteMovieEvent {
  final MovieEntity movieEntity;
  final bool isFavorite;

  ToggleFavoriteMovieEvent({required this.movieEntity, required this.isFavorite});
  
  @override
  List<Object> get props => [movieEntity,isFavorite];
}

class SaveFavoriteMovieEvent extends FavoriteMovieEvent {
  final MovieEntity movie;

  SaveFavoriteMovieEvent({required this.movie});
  @override
  List<Object> get props => [movie];
}

class DeleteFavoriteMovieEvent extends FavoriteMovieEvent {
  final int movieId;

  DeleteFavoriteMovieEvent({required this.movieId});
  @override
  List<Object> get props => [movieId];
}
class CheckIfFavoriteMovieEvent extends FavoriteMovieEvent {
  final int movieId;

  CheckIfFavoriteMovieEvent({required this.movieId});
  @override
  List<Object> get props => [movieId];
}