import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Main(title: 'Flutter Demo Home Page'),
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("APPBAR"),

        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Row(
          children: [
            Column(
              children: [

              ],
            )
          ],
        ),
      )
    );
  }
}
