import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_sqflite/layout/home_layout.dart';
import 'package:todo_app_sqflite/shared/bloc/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeLayout(),
    );
  }
}
