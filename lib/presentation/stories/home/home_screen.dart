
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/common/constants/size_constants.dart';
import 'package:popcorn/di/get_it.dart';
import 'package:popcorn/presentation/blocs/carousel_backdrop/carousel_backdrop_bloc.dart';
import 'package:popcorn/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:popcorn/presentation/blocs/movie_tapped/movie_tapped_bloc.dart';
import 'package:popcorn/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:popcorn/presentation/stories/drawer/navigation_drawer.dart';
import 'package:popcorn/presentation/stories/home/movie_tab/movie_tabs_widget.dart';
import 'package:popcorn/presentation/stories/loading/loading_widget.dart';
import 'package:popcorn/presentation/widgets/app_error_widget.dart';
import 'package:popcorn/common/extensions/size_extension.dart';

import 'movie_carousel/movie_carousel_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 late  MovieCarouselBloc movieCarouselBloc;
 late  CarouselBackdropBloc carouselBackdropBloc;
 late  MovieTappedBloc movieTappedBloc;
 late SearchMovieBloc searchMovieBloc;
  @override
  void initState() {
    super.initState();
    movieCarouselBloc = getItInstance<MovieCarouselBloc>();
    carouselBackdropBloc =movieCarouselBloc.carouselBackdropBloc;
    movieTappedBloc=getItInstance<MovieTappedBloc>();
    searchMovieBloc=getItInstance<SearchMovieBloc>();
    movieCarouselBloc.add(CarouselLoadEvent(defaultIndex: 1));
  }

  @override
  void dispose() {
    super.dispose();
    movieCarouselBloc.close();
    carouselBackdropBloc.close();
    movieTappedBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => movieCarouselBloc,
        ),
        BlocProvider(
          create: (context) => carouselBackdropBloc,
        ),
           BlocProvider(
          create: (context) => movieTappedBloc,
        ),
          BlocProvider(
          create: (context) => searchMovieBloc,
        ),
      ],
      child: Scaffold(
        drawer: NavigationDrawer(),
        body: BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
          builder: (context, state) {
        print(" the state is:$state");
        if (state is MovieCarouselLoaded) {
          return Stack(
            fit: StackFit.expand,
            children: [
              FractionallySizedBox(
                alignment: Alignment.topCenter,
                heightFactor: 0.6,
                child: MovieCarouselWidget(
                    movies: state.movies, defaultIndex: state.defaultIndex),
              ),
              FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                heightFactor: 0.4,
                child: MovieTabsWidget(),
              ),
            ],
          );
        } else if (state is MovieCarouselInitial) {
          return Text('enitial');
        } else if (state is MovieCarouselLoading) {
          return LoadingWidget(size: Sizes.dimen_200.w);
        }else if (state is MovieCarouselError) {
          print('error in here');
              return AppErrorWidget(

                onPressed: () => movieCarouselBloc.add(
                  CarouselLoadEvent(defaultIndex: 1),
                ),
                errorType: state.errorType,
              );
            }
        
         else {
            print('error in else');
          return SizedBox.shrink(
            child: Text('something happend'),
          );
        }
      })),
    );
  }
}
