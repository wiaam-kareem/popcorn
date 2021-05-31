import 'package:get_it/get_it.dart';

import 'package:http/http.dart';
import 'package:popcorn/data/core/api_client.dart';
import 'package:popcorn/data/data_sources/movie_remote_data_source.dart';
import 'package:popcorn/data/repositories/movie_repository_impl.dart';
import 'package:popcorn/domain/repositories/movie_repository.dart';
import 'package:popcorn/domain/usecases/get_coming_soon.dart';
import 'package:popcorn/domain/usecases/get_movie_detail.dart';
import 'package:popcorn/domain/usecases/get_playing_now.dart';
import 'package:popcorn/domain/usecases/get_popular.dart';
import 'package:popcorn/domain/usecases/get_trending.dart';
import 'package:popcorn/presentation/blocs/carousel_backdrop/carousel_backdrop_bloc.dart';
import 'package:popcorn/presentation/blocs/language/language_bloc.dart';
import 'package:popcorn/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:popcorn/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:popcorn/presentation/blocs/movie_tapped/movie_tapped_bloc.dart';

final getItInstance = GetIt.I;
Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));
  getItInstance
      .registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
            getItInstance(),
          ));

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

  getItInstance.registerFactory(() => MovieCarouselBloc(
      getTrending: getItInstance(), carouselBackdropBloc: getItInstance()));
  getItInstance.registerFactory(() => CarouselBackdropBloc());
  getItInstance.registerFactory(() => MovieTappedBloc(
        getPopular:getItInstance(),
        getCommingSoon: getItInstance(),
        getPlayingNow: getItInstance(),
      ));
  getItInstance.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: getItInstance(),
    ),
  );

  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc());
}
