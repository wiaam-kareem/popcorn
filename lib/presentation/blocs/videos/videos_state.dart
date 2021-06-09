part of 'videos_bloc.dart';

abstract class VideosState extends Equatable {
  const VideosState();
  
  @override
  List<Object> get props => [];
}

class VideosInitial extends VideosState {}
class NoVideos extends VideosState {}
class VideoLoading extends VideosState {}
class VideosLoded extends VideosState {
  final List<VideoEntity>videos;

  VideosLoded(this.videos);

  @override
  List<Object> get props => [videos];
}
// class VideosError extends VideosState {
//     final String error;

//   VideosError(this.error);

//   @override
//   List<Object> get props => [error];

// }
