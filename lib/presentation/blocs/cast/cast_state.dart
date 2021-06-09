part of 'cast_bloc.dart';

abstract class CastState extends Equatable {
  const CastState();
  
  @override
  List<Object> get props => [];
}

class CastInitial extends CastState {}
class CastLoading extends CastState {}
class CastLoded extends CastState {
  final List<CastEntity>casts;

  CastLoded({required this.casts});

    @override
  List<Object> get props => [casts];

}
class CastError extends CastState {
  final String castError;

  CastError({required this.castError});
    @override
  List<Object> get props => [castError];

}
