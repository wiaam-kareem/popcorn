part of 'videos_bloc.dart';

abstract class VideosEvent extends Equatable {
  const VideosEvent();

  @override
  List<Object> get props => [];
}
class LoadVideoEvent extends VideosEvent{
  final int videoId;

  LoadVideoEvent({required this.videoId});
   @override
  List<Object> get props => [videoId];
}
