import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:pedantic/pedantic.dart';
import 'package:popcorn/data/tables/movie_table.dart';
import 'package:popcorn/presentation/widgets/popcorn_app.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'di/get_it.dart' as getIt;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));

     final appDocumentDirectory=await pathProvider.getApplicationDocumentsDirectory();
     Hive.init(appDocumentDirectory.path);
     Hive.registerAdapter(MovieTableAdapter());

  unawaited(getIt.init());
  runApp(PopCornApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}
