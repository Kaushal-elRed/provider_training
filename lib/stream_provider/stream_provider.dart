import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<int>(
      catchError: (context, error) {
        return 0;
      },
      updateShouldNotify: (previous, current) {
        return previous != current;
      },
      initialData: 0,
      create: (context) => StreamGiver().getStreamValue(),
      child: const MaterialApp(
        home: StreamWidget(),
      ),
    );
  }
}

class StreamGiver {
  Stream<int> getStreamValue() {
    return Stream.periodic(const Duration(seconds: 1), (x) => x).take(30);
  }
}

class StreamWidget extends StatelessWidget {
  const StreamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print("Value updated");
    return Scaffold(
      body: Center(child: Text(Provider.of<int>(context).toString())),
    );
  }
}
