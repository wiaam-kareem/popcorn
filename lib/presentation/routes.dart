import 'package:flutter/material.dart';
import 'package:popcorn/common/constants/route_constants.dart';
import 'package:popcorn/presentation/stories/favorite_movie/favorite_movies_screen.dart';
import 'package:popcorn/presentation/stories/home/home_screen.dart';
import 'package:popcorn/presentation/stories/login/login_screen.dart';
import 'package:popcorn/presentation/stories/movie_detail.dart/movie_detail_arguments.dart';
import 'package:popcorn/presentation/stories/movie_detail.dart/movie_detail_screen.dart';
import 'package:popcorn/presentation/stories/watch_videos/watch_videos_arguments.dart';
import 'package:popcorn/presentation/stories/watch_videos/watch_videos_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
   RouteList.initial: (context) =>  LoginScreen(),
        RouteList.home: (context) => HomeScreen(),
        RouteList.movieDetail: (context) => MovieDetailScreen(
              movieDetailArguments: setting.arguments as MovieDetailArguments,
            ),
        RouteList.watchTrailer: (context) => WatchVideoScreen(
              watchVideoArguments: setting.arguments as WatchVideosArguments,
            ),
        RouteList.favorite: (context) => FavoriteMovieScreen(),
      };
}