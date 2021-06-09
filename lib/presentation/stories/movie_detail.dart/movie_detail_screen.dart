import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/common/constants/size_constants.dart';
import 'package:popcorn/common/constants/translation_constants.dart';
import 'package:popcorn/di/get_it.dart';
import 'package:popcorn/presentation/blocs/cast/cast_bloc.dart';
import 'package:popcorn/presentation/blocs/favorite_movie/favorite_movie_bloc.dart';
import 'package:popcorn/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:popcorn/presentation/blocs/videos/videos_bloc.dart';
import 'package:popcorn/presentation/stories/loading/loading_widget.dart';
import 'package:popcorn/presentation/stories/movie_detail.dart/big_poster.dart';
import 'package:popcorn/presentation/stories/movie_detail.dart/movie_detail_arguments.dart';
import 'package:popcorn/common/extensions/size_extension.dart';
import 'package:popcorn/common/extensions/string_extension.dart';
import 'package:popcorn/presentation/stories/movie_detail.dart/video_widget.dart';
import 'package:popcorn/presentation/widgets/cast_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailArguments movieDetailArguments;

  const MovieDetailScreen({
    Key? key,
    required this.movieDetailArguments,
  }) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailBloc _movieDetailBloc;
  late FavoriteMovieBloc _favoriteMovieBloc;
  late CastBloc _castBloc;
  late VideosBloc _videosBloc;

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _favoriteMovieBloc = _movieDetailBloc.favoriteMovieBloc;
    _castBloc = _movieDetailBloc.castBloc;
    _videosBloc = _movieDetailBloc.videosBloc;
    _movieDetailBloc.add(
      MovieDetailLoadEvent(
        widget.movieDetailArguments.movieId,
      ),
    );
  }

  @override
  void dispose() {
    _movieDetailBloc.close();
    _favoriteMovieBloc.close();
    _castBloc.close();
    _videosBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: _movieDetailBloc),
            BlocProvider.value(value: _favoriteMovieBloc),
            BlocProvider.value(value: _castBloc),
            BlocProvider.value(value: _videosBloc),
          ],
          child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
              builder: (context, state) {
            if (state is MovieDetailLoaded) {
              final movieDetail = state.movieDetailEntity;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BigPoster(
                      movie: movieDetail,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.dimen_16.w,
                        vertical: Sizes.dimen_8.h,
                      ),
                      child: Text(
                        movieDetail.overview ?? '',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
                      child: Text(
                        TranslationConstants.cast.t(context),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    CastWidget(),
                    VideosWidget(videosBloc: _videosBloc),
                  ],
                ),
              );
            } else if (state is MovieDetailError) {
              return Container(child: Text('error'),);
            }else if(state is MovieDetailLoading){
              print('loading');
               return LoadingWidget(size: Sizes.dimen_200.w);
            }
            return SizedBox.shrink();
          })),
    );
  }
}
