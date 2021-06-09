import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/movie_params.dart';
import 'package:popcorn/domain/entities/video_entity.dart';
import 'package:popcorn/domain/usecases/get_videos.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
 final  GetVideos getVideos;
  VideosBloc({
    required this.getVideos,

   } ) : super(VideosInitial());

  @override
  Stream<VideosState> mapEventToState(
    VideosEvent event,
  ) async* {

    if (event is LoadVideoEvent){
      yield VideoLoading();
      final Either<AppError,List<VideoEntity>> videosOeError=await getVideos(MovieParams(id: event.videoId));
      yield videosOeError.fold(
        (l) =>NoVideos(),
        (r)=>VideosLoded(r) );

     
    }
    
  }
}
