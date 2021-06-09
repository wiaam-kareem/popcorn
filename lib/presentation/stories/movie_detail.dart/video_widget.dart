import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/common/constants/route_constants.dart';
import 'package:popcorn/presentation/blocs/videos/videos_bloc.dart';
import 'package:popcorn/presentation/stories/movie_detail.dart/movie_detail_arguments.dart';
import 'package:popcorn/presentation/stories/watch_videos/watch_videos_arguments.dart';
import 'package:popcorn/presentation/stories/watch_videos/watch_videos_screen.dart';
import 'package:popcorn/presentation/widgets/my_buttton.dart';
import '../../../common/constants/translation_constants.dart';
import '../../../common/extensions/string_extension.dart';

class VideosWidget extends StatelessWidget {
  final VideosBloc videosBloc;

  const VideosWidget({
    Key? key,
    required this.videosBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideosBloc, VideosState>(
      builder: (context, state) {
        if (state is VideosLoded && state.videos.iterator.moveNext()) {
          final _videos = state.videos;
          return Button(
            text: TranslationConstants.watchTrailers,
            onPressed: () {
          
             Navigator.of(context).pushNamed(RouteList.watchTrailer,arguments: WatchVideosArguments(state.videos));
              
           
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}