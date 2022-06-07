import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:test_1/database/firebase_control.dart';
import 'package:test_1/providers/item_provider.dart';
import 'package:test_1/screens/add_item_screen.dart';
import 'package:test_1/theme/ColorScheme.dart';
import 'package:test_1/utils/setting_share_preferences.dart';
import 'package:test_1/screens/setting.dart';
import './screens/home_screen.dart';
import './firebase_options.dart';

bool _isDemoUsingDynamicColors = false;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SettingPreferences.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: ((context) => Item())),
    ],
    child: const TodoList(),
  ));
}

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp(
          theme: AppTheme.lightTheme(lightDynamic),
          darkTheme: AppTheme.darkTheme(darkDynamic),
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const ListDisplay(),
            '/add_item_screen': (context) => const AddItem(),
            '/setting': (context) => const Setting(),
          },
        );
      },
    );
  }
}
