import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/common/constants/size_constants.dart';
import 'package:popcorn/common/constants/translation_constants.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:popcorn/presentation/stories/loading/loading_widget.dart';
import 'package:popcorn/presentation/stories/search_movie/search_movie_card_widget.dart';
import 'package:popcorn/presentation/themes/theme_color.dart';
import 'package:popcorn/presentation/themes/theme_text.dart';
import 'package:popcorn/common/extensions/size_extension.dart';
import 'package:popcorn/presentation/widgets/app_error_widget.dart';
import 'package:popcorn/common/extensions/string_extension.dart';

class CustomSearchDelegate extends SearchDelegate {
  final SearchMovieBloc searchMovieBloc;

  CustomSearchDelegate({required this.searchMovieBloc});
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
      hintStyle: Theme.of(context).textTheme.greySubtitle1,
    ));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: query.isEmpty ? Colors.grey : AppColor.royalBlue,
        ),
        onPressed: query.isEmpty ? null : () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, null);
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: Sizes.dimen_12.h,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchMovieBloc.add(SearchMovieChangeEvent(searchTerm: query));
    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
       bloc: searchMovieBloc,
      builder: (context, state) {
        if (state is SearchMovieError) {
          return AppErrorWidget(
            errorType: state.errorType,
            onPressed: () =>
                searchMovieBloc.add(SearchMovieChangeEvent(searchTerm: query)),
          );
        } else if (state is SearchMovieLoaded) {
          final movies = state.movies;
          if (movies.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_64.w),
                child: Text(
                  TranslationConstants.noMoviesSearched.t(context),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else{
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: movies.length,
                itemBuilder: (context, index) =>
                    SearchMovieCard(movie: movies[index]));
          } 
        }else if(state is SearchMovieLoading){
          return LoadingWidget(size: Sizes.dimen_200.w);
        }
         else {
          return SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox.shrink();
  }
}
