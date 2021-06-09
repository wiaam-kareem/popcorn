import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';
import 'package:popcorn/domain/entities/movie_params.dart';
import 'package:popcorn/domain/entities/no_params.dart';
import 'package:popcorn/domain/usecases/check_if_favorite_movie.dart';
import 'package:popcorn/domain/usecases/delete_favorite_movie.dart';
import 'package:popcorn/domain/usecases/get_favorite_movies.dart';
import 'package:popcorn/domain/usecases/save_movie.dart';

part 'favorite_movie_event.dart';
part 'favorite_movie_state.dart';

class FavoriteMovieBloc extends Bloc<FavoriteMovieEvent, FavoriteMovieState> {
  final GetFavoriteMovies getFavoriteMovies;
  final SaveFavoriteMovie saveFavoriteMovie;
  final DeleteFavoriteMovie deleteFavoriteMovie;
  final CheckIfFavoriteMovie checkIfFavoriteMovie;

  FavoriteMovieBloc({
   required this.getFavoriteMovies,
   required this.saveFavoriteMovie,
   required this.deleteFavoriteMovie,
   required this.checkIfFavoriteMovie,
 
  }) : super(FavoriteMovieInitial());

  @override
  Stream<FavoriteMovieState> mapEventToState(
    FavoriteMovieEvent event,
  ) async* {
    if (event is ToggleFavoriteMovieEvent) {
      if (event.isFavorite) {
        await deleteFavoriteMovie(MovieParams(id:event.movieEntity.id));
      } else {
        await saveFavoriteMovie(event.movieEntity);
      }
      final response =
          await checkIfFavoriteMovie(MovieParams(id:event.movieEntity.id));
      yield response.fold(
        (l) => FavoriteMovieError(),
        (r) => IsFavoriteMovieCheck(isFavorite: r),
      );
    } else if (event is LoadFavoriteMoviesEvent) {
      yield* _fetchLoadFavoriteMovies();
    } else if (event is DeleteFavoriteMovieEvent) {
      await deleteFavoriteMovie(MovieParams(id:event.movieId));
      yield* _fetchLoadFavoriteMovies();
    } else if (event is CheckIfFavoriteMovieEvent) {
      final response = await checkIfFavoriteMovie(MovieParams(id:event.movieId));
      yield response.fold(
        (l) => FavoriteMovieError(),
        (r) => IsFavoriteMovieCheck(isFavorite: r),
      );
    }
  }

  Stream<FavoriteMovieState> _fetchLoadFavoriteMovies() async* {
    yield FavoriteMovieLoading();
     await Future.delayed(Duration(milliseconds: 3000));
    final Either<AppError, List<MovieEntity>> response =
        await getFavoriteMovies(NoParams());

    yield response.fold(
      (l) => FavoriteMovieError(),
      (r) => FavoriteMoviesLoaded(movies:r),
    );
  }
}
