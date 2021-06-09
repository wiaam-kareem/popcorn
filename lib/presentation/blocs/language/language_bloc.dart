import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:popcorn/common/constants/languages.dart';
import 'package:popcorn/domain/entities/language_entity.dart';
import 'package:popcorn/domain/entities/no_params.dart';
import 'package:popcorn/domain/usecases/get_prefered_language.dart';
import 'package:popcorn/domain/usecases/save_movie%20copy.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final GetPreferedLanguage getPreferedLanguage;
  final UpdateLanguage updateLanguage;
  LanguageBloc(
      {required this.getPreferedLanguage, required this.updateLanguage})
      : super(
          LanguageLoaded(
            Locale(Languages.languages[0].code),
          ),
        );

  @override
  Stream<LanguageState> mapEventToState(
    LanguageEvent event,
  ) async* {
    if (event is ToggleLanguageEvent) {
      await updateLanguage(event.language.code);
      add(LoadPreferredLanguageEvent());
      yield LanguageLoaded(Locale(event.language.code));
    } else {
      if (event is LoadPreferredLanguageEvent) {
        final response = await getPreferedLanguage(NoParams());
        yield response.fold((l) => LanguageError(), (r) {
          if (r != null) {
            return LanguageLoaded(Locale(r));
          } else {
            return LanguageLoaded(
              Locale(Languages.languages[0].code),
            );
          }
        });
      }
    }
  }
}
