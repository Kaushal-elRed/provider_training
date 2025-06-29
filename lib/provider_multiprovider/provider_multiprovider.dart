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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Provider(
      //   create: (context) => CounterProvider(),
      //   child: Provider(
      //     create: (context) => CounterProvider1(),
      //     child: const MyWidget(),
      //   ),
      // ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CounterProvider()),
          Provider(create: (context) => CounterProvider1()),
          Consumer<CounterProvider>(
            builder: (context, value, child) =>
                Provider.value(value: value.count, child: child),
          )
        ],
        builder: (context, child) {
          print("Build again after 3 second");
          return child!;
        },
        child: const MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<CounterProvider>(context);
    Provider.of<CounterProvider1>(context);
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text("Provider"),
          onPressed: () {},
        ),
      ),
    );
  }
}

class CounterProvider extends ChangeNotifier {
  int count = 0;
  CounterProvider() {
    print("Counter Provider - ${DateTime.now()}");
    Future.delayed(
      const Duration(seconds: 3),
      () {
        print("Notiying listeners");
        notifyListeners();
      },
    );
  }
}

class CounterProvider1 {
  CounterProvider1() {
    print("Counter Provider 1 - ${DateTime.now()}");
  }
}
