part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}
class SearchMovieChangeEvent extends SearchMovieEvent{
  final String searchTerm ;

  SearchMovieChangeEvent({ required this.searchTerm});

  @override
  List<Object> get props => [searchTerm];

}
