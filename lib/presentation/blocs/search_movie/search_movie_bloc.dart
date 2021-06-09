import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/movie_entity.dart';
import 'package:popcorn/domain/entities/movie_search_params.dart';
import 'package:popcorn/domain/usecases/get_serch_movie.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final GetSearchMovie getSearchMovie;
  SearchMovieBloc({required this.getSearchMovie}) : super(SearchMovieInitial());

  @override
  Stream<SearchMovieState> mapEventToState(
    SearchMovieEvent event,
  ) async* {
    if (event is SearchMovieChangeEvent) {
      if (event.searchTerm.length > 2) {
        yield SearchMovieLoading();
          await Future.delayed(Duration(milliseconds: 2000));
        final Either<AppError, List<MovieEntity>> response =
            await getSearchMovie(MovieSearchParams(searchTerm: event.searchTerm));
        yield response.fold(
          (l) => SearchMovieError(l.appErrorType),
          (r) => SearchMovieLoaded(movies: r),
        );
      }
    }
  }
}

