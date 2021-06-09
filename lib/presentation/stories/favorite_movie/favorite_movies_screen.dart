import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/common/constants/size_constants.dart';
import 'package:popcorn/common/constants/translation_constants.dart';
import 'package:popcorn/di/get_it.dart';
import 'package:popcorn/presentation/blocs/favorite_movie/favorite_movie_bloc.dart';
import 'package:popcorn/presentation/stories/favorite_movie/favorite_movie_grid_view.dart';
import 'package:popcorn/common/extensions/string_extension.dart';
import 'package:popcorn/presentation/stories/loading/loading_widget.dart';
import 'package:popcorn/common/extensions/size_extension.dart';

class FavoriteMovieScreen extends StatefulWidget {
  @override
  _FavoriteMovieScreenState createState() => _FavoriteMovieScreenState();
}

class _FavoriteMovieScreenState extends State<FavoriteMovieScreen> {
  late FavoriteMovieBloc _favoriteMovieBloc;

  @override
  void initState() {
    super.initState();
    _favoriteMovieBloc = getItInstance<FavoriteMovieBloc>();
    _favoriteMovieBloc.add(LoadFavoriteMoviesEvent());
  }

  @override
  void dispose() {
    _favoriteMovieBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TranslationConstants.favoriteMovies.t(context),
        ),
      ),
      body: BlocProvider.value(
        value: _favoriteMovieBloc,
        child: BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
          builder: (context, state) {
            if (state is FavoriteMoviesLoaded) {
              if (state.movies.isEmpty) {
                return Center(
                  child: Text(
                    TranslationConstants.noFavoriteMovie.t(context),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                );
              }
              return FavoriteMovieGridView(
                movies: state.movies,
              );
            } else if(state is FavoriteMovieLoading){
              return LoadingWidget(size: Sizes.dimen_200.w);
              
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
