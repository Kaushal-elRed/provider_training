import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureProvider<String>(
      catchError: (context, error) {
        return "Error $error";
      },
      updateShouldNotify: (previous, current) {
        return previous != current;
      },
      initialData: "I am from present",
      create: (context) async => await FutureGiver().getFutureValue(),
      child: const MaterialApp(
        home: FutureWidget(),
      ),
    );
  }
}

class FutureGiver {
  Future<String> getFutureValue() {
    return Future.delayed(const Duration(seconds: 3), () {
      // return "I am from present";
      // throw Exception();
      return "I am from Future";
    });
  }
}

class FutureWidget extends StatelessWidget {
  const FutureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print("Value updated");
    return Scaffold(
      body: Center(child: Text(Provider.of<String>(context))),
    );
  }
}
