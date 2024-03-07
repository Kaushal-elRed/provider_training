import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChangeNotifierProvider.value',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // By wrapping changenotifierprovider inside home makes it available to
      // only [ChangeNotifierProviderValue] widget and not to other context
      // if I wrap this above Material app then it will be global and no need
      // of passing instance through value. Simply is a local provider instance
      home: ChangeNotifierProvider<CounterProvider>(
        create: (context) => CounterProvider(),
        child: const ChangeNotifierProviderValue(),
      ),
    );
  }
}

class ChangeNotifierProviderValue extends StatelessWidget {
  const ChangeNotifierProviderValue({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterProvider>(context, listen: false);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<CounterProvider>(builder: (context, value, child) {
            return Text("Counter ${counter._x}");
          }),
          TextButton(
            child: const Text("Increment"),
            onPressed: () {
              counter.increment();
            },
          ),
          TextButton(
            child: const Text("Route"),
            onPressed: () {
              // Here by using ChangeNotifierProvider.value we have passed
              // Previously created instance of counter to next page this way
              // we didnt created new instance
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                    value: counter,
                    child: const PageTwoChangeNotifierProviderValue(),
                  ),
                ),
              );
            },
          ),
        ],
      )),
    );
  }
}

class CounterProvider with ChangeNotifier {
  int _x = 0;
  int get x => _x;
  void increment() {
    _x++;
    print("Counter value is $_x");
    notifyListeners();
  }
}

class PageTwoChangeNotifierProviderValue extends StatelessWidget {
  const PageTwoChangeNotifierProviderValue({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CounterProvider>(builder: (context, value, child) {
              return Text("Counter ${counter._x}");
            }),
            TextButton(
              child: const Text("Increment"),
              onPressed: () {
                counter.increment();
              },
            ),
          ],
        ),
      ),
    );
  }
}
