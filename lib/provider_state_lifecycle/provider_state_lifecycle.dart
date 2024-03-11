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
      home: Provider(
        lazy: false,
        dispose: (context, value) {},
        create: (context) => CounterProvider(),
        child: ProviderStateLifeCycle(),
      ),
    );
  }
}

class ProviderStateLifeCycle extends StatefulWidget {
  ProviderStateLifeCycle({super.key}) {
    print("Constructor");
  }
  @override
  State<ProviderStateLifeCycle> createState() {
    print("Create state");
    return _ProviderStateLifeCycleState();
  }
}

class _ProviderStateLifeCycleState extends State<ProviderStateLifeCycle> {
  int i = 0;

  @override
  void initState() {
    super.initState();
    print("Init State");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.dependOnInheritedWidgetOfExactType(aspect: const MaterialApp());
    print("Did Change Dependency");
  }

  @override
  void didUpdateWidget(covariant ProviderStateLifeCycle oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("Did Update Widget");
  }

  @override
  void dispose() {
    super.dispose();
    print("Dispose Widget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("Deactivate");
  }

  @override
  Widget build(context) {
    final counterProvider = Provider.of<CounterProvider>(context);
    final counterProvider2 = Provider.of<CounterProvider>(context);
    final counterProvider3 = Provider.of<CounterProvider>(context);
    final counterProvider4 = Provider.of<CounterProvider>(context);
    print("Build");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  i++;
                });
              },
              child: Text("Tap me $i"),
            ),
            if (i == 5) const Text("Its 5 now")
          ],
        ),
      ),
    );
  }
}

class CounterProvider {
  CounterProvider() {
    print("Counter Provider");
  }
}
