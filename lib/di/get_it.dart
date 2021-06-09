import 'package:get_it/get_it.dart';

import 'package:http/http.dart';
import 'package:popcorn/data/core/api_client.dart';
import 'package:popcorn/data/data_sources/authentication_local_data_source.dart';
import 'package:popcorn/data/data_sources/authentication_remote_data_source.dart';
import 'package:popcorn/data/data_sources/language_local_data_source.dart';
import 'package:popcorn/data/data_sources/movie_local_data_source.dart';
import 'package:popcorn/data/data_sources/movie_remote_data_source.dart';
import 'package:popcorn/data/repositories/app_repository_impl.dart';
import 'package:popcorn/data/repositories/authentication_repository_impl.dart';
import 'package:popcorn/data/repositories/movie_repository_impl.dart';
import 'package:popcorn/domain/repositories/app_repository.dart';
import 'package:popcorn/domain/repositories/authentication_repository.dart';
import 'package:popcorn/domain/repositories/movie_repository.dart';
import 'package:popcorn/domain/usecases/check_if_favorite_movie.dart';
import 'package:popcorn/domain/usecases/delete_favorite_movie.dart';
import 'package:popcorn/domain/usecases/get_cast_crew.dart';
import 'package:popcorn/domain/usecases/get_coming_soon.dart';
import 'package:popcorn/domain/usecases/get_favorite_movies.dart';
import 'package:popcorn/domain/usecases/get_movie_detail.dart';
import 'package:popcorn/domain/usecases/get_playing_now.dart';
import 'package:popcorn/domain/usecases/get_popular.dart';
import 'package:popcorn/domain/usecases/get_prefered_language.dart';
import 'package:popcorn/domain/usecases/get_prefered_theme.dart';
import 'package:popcorn/domain/usecases/get_serch_movie.dart';
import 'package:popcorn/domain/usecases/get_trending.dart';
import 'package:popcorn/domain/usecases/get_videos.dart';
import 'package:popcorn/domain/usecases/login_user.dart';
import 'package:popcorn/domain/usecases/logout_user.dart';
import 'package:popcorn/domain/usecases/save_movie%20copy.dart';
import 'package:popcorn/domain/usecases/save_movie.dart';
import 'package:popcorn/domain/usecases/update_theme.dart';
import 'package:popcorn/presentation/blocs/carousel_backdrop/carousel_backdrop_bloc.dart';
import 'package:popcorn/presentation/blocs/cast/cast_bloc.dart';
import 'package:popcorn/presentation/blocs/favorite_movie/favorite_movie_bloc.dart';
import 'package:popcorn/presentation/blocs/language/language_bloc.dart';
import 'package:popcorn/presentation/blocs/loading/loading_bloc.dart';
import 'package:popcorn/presentation/blocs/login_cubit/login_cubit_cubit.dart';
import 'package:popcorn/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:popcorn/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:popcorn/presentation/blocs/movie_tapped/movie_tapped_bloc.dart';
import 'package:popcorn/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:popcorn/presentation/blocs/theme/theme_cubit.dart';
import 'package:popcorn/presentation/blocs/videos/videos_bloc.dart';

final getItInstance = GetIt.I;
Future init() async {
  // register client
  //******************************
  //******************************
  getItInstance.registerLazySingleton<Client>(() => Client());
  // register ApiClient
  //******************************
  //******************************
  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));
  // register dataSources
  //******************************
  //******************************

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl());
    getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(getItInstance()));
    getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());
  getItInstance
      .registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
            getItInstance(),
            getItInstance(),
          ));
  getItInstance.registerLazySingleton<LanguageLocalDataSource>(
      () => LanguageLocalDataSourceImpl());
  getItInstance.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(
        languageLocalDataSource: getItInstance(),
      ));
   getItInstance.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(
     getItInstance(),
     getItInstance()
   ));
  // register UseCases
  //******************************
  //******************************
  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));
  getItInstance.registerLazySingleton<GetCommingSoon>(
      () => GetCommingSoon(getItInstance()));

  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));
  getItInstance
      .registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));

  getItInstance
      .registerLazySingleton<GetCastCrew>(() => GetCastCrew(getItInstance()));
  getItInstance.registerLazySingleton<GetSearchMovie>(
      () => GetSearchMovie(getItInstance()));
  getItInstance.registerLazySingleton<SaveFavoriteMovie>(
      () => SaveFavoriteMovie(getItInstance()));
  getItInstance.registerLazySingleton<DeleteFavoriteMovie>(
      () => DeleteFavoriteMovie(getItInstance()));
  getItInstance.registerLazySingleton<CheckIfFavoriteMovie>(
      () => CheckIfFavoriteMovie(getItInstance()));
  getItInstance.registerLazySingleton<GetFavoriteMovies>(
      () => GetFavoriteMovies(getItInstance()));

  getItInstance.registerLazySingleton<GetPreferedLanguage>(
      () => GetPreferedLanguage(getItInstance()));
  getItInstance.registerLazySingleton<UpdateLanguage>(
      () => UpdateLanguage(getItInstance()));
       getItInstance.registerLazySingleton<LoginUser>(
      () => LoginUser(getItInstance()));
       getItInstance.registerLazySingleton<LogoutUser>(
      () => LogoutUser(getItInstance()));
         getItInstance.registerLazySingleton<GetPreferredTheme>(
      () => GetPreferredTheme(getItInstance()));
         getItInstance.registerLazySingleton<UpdateTheme>(
      () => UpdateTheme(getItInstance()));
  // register Blocs
  //******************************
  //******************************
   getItInstance.registerSingleton<LanguageBloc>(LanguageBloc(
    getPreferedLanguage: getItInstance(),
    updateLanguage: getItInstance(),
  ));
   getItInstance.registerSingleton<LoadingBloc>(LoadingBloc( ));

  getItInstance.registerFactory(() => MovieCarouselBloc(
   
      getTrending: getItInstance(), carouselBackdropBloc: getItInstance()));
  getItInstance.registerFactory(() => CarouselBackdropBloc());
  getItInstance.registerFactory(() => MovieTappedBloc(
        getPopular: getItInstance(),
        getCommingSoon: getItInstance(),
        getPlayingNow: getItInstance(),
      ));
  getItInstance.registerFactory(() => CastBloc(getCastCrew: getItInstance()));

  getItInstance.registerFactory(
    () => MovieDetailBloc(
      castBloc: getItInstance(),
      favoriteMovieBloc: getItInstance(),
      getMovieDetail: getItInstance(),
      videosBloc: getItInstance(),
      loadingBloc: getItInstance()
    ),
  );

  getItInstance.registerFactory(
    () => FavoriteMovieBloc(
      saveFavoriteMovie: getItInstance(),
      deleteFavoriteMovie: getItInstance(),
      checkIfFavoriteMovie: getItInstance(),
      getFavoriteMovies: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => VideosBloc(
      getVideos: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => SearchMovieBloc(
      getSearchMovie: getItInstance(),
    ),
  );
   getItInstance.registerFactory(
    () => LoginCubit(
      loginUser: getItInstance(),
      logoutUser: getItInstance(),
    ),
  );
     getItInstance.registerFactory(
    () => ThemeCubit(
      getPreferredTheme: getItInstance(),
     updateTheme: getItInstance())
    
    
  );
 
}
