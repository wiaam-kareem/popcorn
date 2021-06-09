import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/common/constants/size_constants.dart';

import 'package:popcorn/presentation/blocs/movie_tapped/movie_tapped_bloc.dart';
import 'package:popcorn/presentation/stories/home/movie_tab/movie_listview_biulder.dart';
import 'package:popcorn/presentation/stories/home/movie_tab/movie_tabs_constant.dart';
import 'package:popcorn/presentation/stories/home/movie_tab/tab_title_widget.dart';
import 'package:popcorn/common/extensions/size_extension.dart';
import 'package:popcorn/presentation/stories/loading/loading_widget.dart';
import 'package:popcorn/presentation/widgets/app_error_widget.dart';


class MovieTabsWidget extends StatefulWidget {
  @override
  _MovieTabsWidgetState createState() => _MovieTabsWidgetState();
}

class _MovieTabsWidgetState extends State<MovieTabsWidget> with SingleTickerProviderStateMixin{
  MovieTappedBloc get movieTappedBloc=>BlocProvider.of<MovieTappedBloc>(context);
   int initialIndex=0;
   @override
  void initState() {
    super.initState();
    movieTappedBloc.add(MovieTappedChangedEvent(currentTappedIndex: initialIndex));
  }
  @override
  void dispose() {
    super.dispose();
    movieTappedBloc.close();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTappedBloc, MovieTappedState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: Sizes.dimen_4.h),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0;
                      i < MovieTabConstants.movieTab.length;
                      i++)
                    TabTitleWidget(
                      onTab:()=>_onTabTapped(i),
                      title: MovieTabConstants.movieTab[i].title,
                       isSellected: MovieTabConstants.movieTab[i].index ==
                           state.currentTappedIndex,
                    )
                ],
              ),
              if (state is MovieTappedChanged)
          Expanded(
                  child: MovieListView(movies: state.movies)
                ),
                if(state is MovieTabLoadError)
                  Expanded(
                  child: AppErrorWidget(
                    errorType: state.errorType,
                    onPressed: () => movieTappedBloc.add(
                      MovieTappedChangedEvent(
                        currentTappedIndex: state.currentTappedIndex,
                      ),
                    ),
                  ),
                ),
                if(state is MovieTappedLoading)
                LoadingWidget(size: Sizes.dimen_150.w)
            ],
          ),
        );
      },
    );
  }

  void _onTabTapped(int index) {
    movieTappedBloc.add(MovieTappedChangedEvent(currentTappedIndex: index));
  }
}