import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:popcorn/common/constants/languages.dart';
import 'package:popcorn/common/screen_utilities/screen_util.dart';
import 'package:popcorn/di/get_it.dart';
import 'package:popcorn/presentation/app_localizations.dart';
import 'package:popcorn/presentation/blocs/language/language_bloc.dart';
import 'package:popcorn/presentation/stories/home/home_screen.dart';
import 'package:popcorn/presentation/themes/theme_color.dart';
import 'package:popcorn/presentation/themes/theme_text.dart';

class PopCornApp extends StatefulWidget {
 
  @override
  _PopCornAppState createState() => _PopCornAppState();
}

class _PopCornAppState extends State<PopCornApp> {
  LanguageBloc _languageBloc;
  @override
  void initState() {
    super.initState();
    _languageBloc=getItInstance<LanguageBloc>();
  }
  @override
  void dispose() {
  _languageBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return BlocProvider<LanguageBloc>.value(
      value:_languageBloc,
          child: BlocBuilder<LanguageBloc,LanguageState>(
            builder:(context,state){
                      if(state is LanguageLoaded) {
                      return   MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'POPCORN',
        supportedLocales: Languages.languages.map((e) =>Locale( e.code)).toList(),
        locale: state.locale,
        localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            AppLocalizations.delegate
        ],
        theme: ThemeData( 
            primaryColor: AppColor.vulcan,
            accentColor: AppColor.royalBlue,
            unselectedWidgetColor: AppColor.royalBlue,
            scaffoldBackgroundColor: AppColor.vulcan,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: ThemeText.getTextTheme(),
            appBarTheme: const AppBarTheme(elevation: 0),
        ),

        home: HomeScreen(),
      );
                      }else{
                        return SizedBox.shrink();
                      }} ,
          ),
    );
  }
}