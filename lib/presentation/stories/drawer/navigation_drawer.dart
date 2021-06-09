import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn/common/constants/languages.dart';
import 'package:popcorn/common/constants/route_constants.dart';
import 'package:popcorn/common/constants/size_constants.dart';
import 'package:popcorn/common/constants/translation_constants.dart';
import 'package:popcorn/common/extensions/size_extension.dart';
import 'package:popcorn/di/get_it.dart';
import 'package:popcorn/presentation/app_localizations.dart';
import 'package:popcorn/presentation/blocs/language/language_bloc.dart';
import 'package:popcorn/presentation/blocs/login_cubit/login_cubit_cubit.dart';
import 'package:popcorn/presentation/blocs/theme/theme_cubit.dart';
import 'package:popcorn/presentation/stories/drawer/navigation_expanded_list_item.dart';
import 'package:popcorn/presentation/stories/drawer/navigation_list_item.dart';
import 'package:popcorn/presentation/stories/favorite_movie/favorite_movies_screen.dart';
import 'package:popcorn/presentation/themes/theme_color.dart';
import 'package:popcorn/presentation/widgets/logo.dart';
import 'package:popcorn/common/extensions/string_extension.dart';
import 'package:popcorn/presentation/widgets/seperator.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer();

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  late LanguageBloc _languageBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _languageBloc = getItInstance<LanguageBloc>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _languageBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4,
          ),
        ],
      ),
      width: Sizes.dimen_300.w,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: Sizes.dimen_8.h,
                bottom: Sizes.dimen_18.h,
                left: Sizes.dimen_8.w,
                right: Sizes.dimen_8.w,
              ),
              child: Logo(
                height: Sizes.dimen_20.h,
              ),
            ),
            NavigationListItem(
                title: TranslationConstants.favoriteMovies.t(context),
                onPressed: () =>
                    Navigator.of(context).pushNamed(RouteList.favorite)),
            NavigationExpandedListItem(
                title: TranslationConstants.language.t(context),
                children: Languages.languages.map((e) => e.value).toList(),
                onPressed: (index) => _onLanguageSellected(index)),
            NavigationListItem(
              title: TranslationConstants.feedback.t(context),
              onPressed: () {},
            ),
            NavigationListItem(
              title: TranslationConstants.about.t(context),
              onPressed: () {},
            ),
                     BlocListener<LoginCubit, LoginState>(
              listenWhen: (previous, current) => current is LogoutSuccess,
              listener: (context, state) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteList.initial, (route) => false);
              },
              child: NavigationListItem(
                

                title: TranslationConstants.logout.t(context),
                onPressed: () {
                  BlocProvider.of<LoginCubit>(context).logout(context: context);
                },
              ),),
              Separator(),
            BlocBuilder<ThemeCubit, Themes>(builder: (context, theme) {
              return Align(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                  icon: Icon(
                    theme == Themes.dark
                        ? Icons.brightness_4_sharp
                        : Icons.brightness_7_sharp,
                    color: context.read<ThemeCubit>().state == Themes.dark
                        ? Colors.white
                        : AppColor.vulcan,
                    size: Sizes.dimen_40.w,
                  ),
                ),
              );
            }),
             
          
          ],
        ),
      ),
    );
  }

  void _onLanguageSellected(int index) {
    _languageBloc.add(ToggleLanguageEvent(Languages.languages[index]));
  }
}
