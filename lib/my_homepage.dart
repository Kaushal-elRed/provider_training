import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_training/counter.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),

            // This will rebuild everytime counter emits any change
            Consumer<Counter>(
              builder: (context, value, child) {
                print("Consumer building");
                return Text(
                  "${value.counter}",
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),

            // This will rebuild only when selectorCounter value is changed
            Selector<Counter, int>(
              selector: (context, counter) => counter.selectorCounter,
              builder: (context, value, child) {
                print("Selector building");
                return Text(
                  "$value",
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: counter.increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton.small(
            backgroundColor: Colors.pink,
            onPressed: counter.incSelectorCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
