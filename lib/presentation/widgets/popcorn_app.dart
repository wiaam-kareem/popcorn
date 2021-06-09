import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:popcorn/common/constants/languages.dart';
import 'package:popcorn/common/constants/route_constants.dart';
import 'package:popcorn/common/screen_utilities/screen_util.dart';
import 'package:popcorn/di/get_it.dart';
import 'package:popcorn/presentation/app_localizations.dart';
import 'package:popcorn/presentation/blocs/language/language_bloc.dart';
import 'package:popcorn/presentation/blocs/loading/loading_bloc.dart';
import 'package:popcorn/presentation/blocs/login_cubit/login_cubit_cubit.dart';
import 'package:popcorn/presentation/blocs/theme/theme_cubit.dart';
import 'package:popcorn/presentation/fade_page_route_builder.dart';
import 'package:popcorn/presentation/routes.dart';
import 'package:popcorn/presentation/themes/theme_color.dart';
import 'package:popcorn/presentation/themes/theme_text.dart';

class PopCornApp extends StatefulWidget {
  @override
  _PopCornAppState createState() => _PopCornAppState();
}

class _PopCornAppState extends State<PopCornApp> {
  late LanguageBloc _languageBloc;
  late LoadingBloc _loadingBloc;
 late LoginCubit _loginCubit;
 late ThemeCubit _themeCubit;
  @override
  void initState() {
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
    _languageBloc.add(LoadPreferredLanguageEvent());
    _loginCubit=getItInstance<LoginCubit>();
    _themeCubit=getItInstance<ThemeCubit>();
     
    _loadingBloc = getItInstance<LoadingBloc>();
  }

  @override
  void dispose() {
    _languageBloc.close();
    _loadingBloc.close();
    _loginCubit.close();
    _themeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>.value(value: _languageBloc),
        BlocProvider<LoadingBloc>.value(value: _loadingBloc),
        BlocProvider<LoginCubit>.value(value: _loginCubit),
        BlocProvider<ThemeCubit>.value(value: _themeCubit),
      ],
      child:BlocBuilder<ThemeCubit,Themes>(
        builder:(context,theme){
          return  BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state is LanguageLoaded) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'POPCORN',
              supportedLocales:
                  Languages.languages.map((e) => Locale(e.code)).toList(),
              locale: state.locale,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                AppLocalizations.delegate
              ],
            theme: ThemeData(
                    unselectedWidgetColor: AppColor.royalBlue,
                    primaryColor:
                        theme == Themes.dark ? AppColor.vulcan : Colors.white,
                    accentColor: AppColor.royalBlue,
                    scaffoldBackgroundColor:
                        theme == Themes.dark ? AppColor.vulcan : Colors.white,
                    brightness: theme == Themes.dark
                        ? Brightness.dark
                        : Brightness.light,
                    cardTheme: CardTheme(
                      color:
                          theme == Themes.dark ? Colors.white : AppColor.vulcan,
                    ),
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    textTheme: theme == Themes.dark
                        ? ThemeText.getTextTheme()
                        : ThemeText.getLightTextTheme(),
                    appBarTheme: const AppBarTheme(elevation: 0),
                    inputDecorationTheme: InputDecorationTheme(
                      hintStyle: Theme.of(context).textTheme.greySubtitle1,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: theme == Themes.dark
                              ? Colors.white
                              : AppColor.vulcan,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
              builder: (context, child) {
                  return child!;
                  // LoadingScreen(
                  //   screen: child!,
                  // );
              },
              initialRoute: RouteList.initial,
              onGenerateRoute: (RouteSettings settings) {
                print(settings.name);
                final routes = Routes.getRoutes(settings);
                final WidgetBuilder? builder = routes[settings.name];
                return FadePageRouteBuilder(
                  builder: builder!,
                  settings: settings,
                );
              },
            );
          } else {
            return SizedBox.shrink();
          }
        },
      );
        })
      
    );
  }
}
