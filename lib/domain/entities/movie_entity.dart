
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class MovieEntity extends Equatable{
 final int id;
 final String posterPath;
 final String backdropPath;
 final String title;
 final num voteAverage;
 final String overview;
 final String releaseDate;

 const MovieEntity({this.id,
 @required this.posterPath,
 @required this.backdropPath,
 @required this.title,
 @required this.voteAverage,
 @required this.releaseDate,
 this.overview,
  } );

  @override
  // TODO: implement props
  List<Object> get props =>[id,title];
 
  @override
  // TODO: implement stringify
  bool get stringify => true;
 
}