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
      title: 'Provider vs ChangeNotifierProvider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // For Provider
      // home: Provider<CounterProvider>(
      //   create: (context) => CounterProvider(),
      //   child: const ProviderVsChangeNotifierProvider(),
      // ),

      // For ChangeNotifierProvider
      home: ChangeNotifierProvider<CounterProvider>(
        create: (context) => CounterProvider(),
        child: const ProviderVsChangeNotifierProvider(),
      ),
    );
  }
}

class ProviderVsChangeNotifierProvider extends StatelessWidget {
  const ProviderVsChangeNotifierProvider({super.key});

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
            child: const Text("Tap me"),
            onPressed: () {
              counter.increment();
            },
          )
        ],
      )),
    );
  }
}

// Provider will not reflect the changes untill reload
// class CounterProvider {
//   int _x = 0;
//   int get x => _x;
//   void increment() {
//     _x++;
//     print("Counter value is $_x");
//   }
// }

// Change Notifier Provider will reflect the changes with notifylisteners
class CounterProvider with ChangeNotifier {
  int _x = 0;
  int get x => _x;
  void increment() {
    _x++;
    print("Counter value is $_x");
    notifyListeners();
  }
}
