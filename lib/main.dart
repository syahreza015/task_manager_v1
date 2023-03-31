import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager_v1/database.dart';
import 'package:task_manager_v1/page/home.dart';
import 'package:task_manager_v1/page/settings.dart';
import 'package:task_manager_v1/page/splash.dart';
import 'package:task_manager_v1/state/actions.dart';
import 'package:task_manager_v1/state/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Database database = await DatabaseHelper.createDatabase();
  List<Map<String, dynamic>> data = await database.rawQuery("SELECT * FROM task");
  store.dispatch(SetDatabase(database: database));
  store.dispatch(SetData(data: data));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, MaterialColor>(
        converter: (store) => store.state.themeColor,
        builder: (context, vm) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: store.state.themeColor,
          ),
          initialRoute: "/splash",
          routes: {
            "/splash": (context) => const SplashSCreen(),
            "/": (context) => const HomePage(),
            "/settings": (context) => const SettingsPage()
          },
        ),
      ),
    );
  }
}
