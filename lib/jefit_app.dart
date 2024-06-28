import 'package:flutter/material.dart';

class JefitApp extends StatelessWidget {
  const JefitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Jefit App'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    ));
  }
}
