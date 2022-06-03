import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:test_1/providers/item_provider.dart';
import 'package:test_1/screens/add_item_screen.dart';
import './screens/home_screen.dart';

void main(List<String> args) {
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
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const ListDisplay(),
        '/add_item_screen': (context) => const AddItem(),
      },
    );
  }
}
