import 'package:dartz/dartz.dart';
import 'package:popcorn/common/constants/translation_constants.dart';
import 'package:popcorn/presentation/stories/home/movie_tab/tab.dart';

class MovieTabConstants{
  static const List<Tab>movieTab=const[
const Tab(index: 0, title: TranslationConstants.popular),
const Tab(index: 1, title:  TranslationConstants.now),
const Tab(index: 2, title:  TranslationConstants.soon),

  ];
}