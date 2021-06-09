import 'package:hive/hive.dart';
import 'package:pedantic/pedantic.dart';

abstract class LanguageLocalDataSource{
  Future<void>updateLanguage(String languageCode);
  Future<String?>getPreferedLanguage();
    Future<void> updateTheme(String themeName);
  Future<String> getPreferredTheme();
}
class LanguageLocalDataSourceImpl extends LanguageLocalDataSource{
  @override
  Future<String?> getPreferedLanguage() async{
   final languageBox=await Hive.openBox('LanguageBox');
  return await languageBox.get('prefered_language');
  }

  @override
  Future<void> updateLanguage(String languageCode)async {
  final languageBox=await Hive.openBox('LanguageBox');
 await languageBox.put('prefered_language', languageCode);
  }

  @override
  Future<String> getPreferredTheme() async {
    final themeBox = await Hive.openBox('themeBox');
    return themeBox.get('preferred_theme') ?? 'dark';
  }

  @override
  Future<void> updateTheme(String themeName) async {
    final themeBox = await Hive.openBox('themeBox');
    unawaited(themeBox.put('preferred_theme', themeName));
  }

}