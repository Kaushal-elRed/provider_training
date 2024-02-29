import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_training/counter.dart';
import 'package:provider_training/my_homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<Counter>(
          create: (context) => Counter(),
          child: const MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}
