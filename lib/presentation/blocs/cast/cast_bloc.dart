import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:popcorn/domain/entities/app_error.dart';
import 'package:popcorn/domain/entities/cast_entity.dart';
import 'package:popcorn/domain/entities/movie_params.dart';
import 'package:popcorn/domain/usecases/get_cast_crew.dart';


part 'cast_event.dart';
part 'cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  final GetCastCrew getCastCrew;
  CastBloc({required this.getCastCrew}) : super(CastInitial());

  @override
  Stream<CastState> mapEventToState(
    CastEvent event,
  ) async* {
    if(event is LoadCastEvent){
      yield CastLoading();
       await Future.delayed(Duration(milliseconds: 5000));
      final Either<AppError,List<CastEntity>>castOrError=await getCastCrew(MovieParams(id: event.movieId));
     yield castOrError.fold(
       (l) => CastError(castError: l.appErrorType.toString()),
       (r) => CastLoded(casts: r),
       );
    }
  }
}
