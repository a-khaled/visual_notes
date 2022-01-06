import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visual notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Center(child:Text('no notes yet')),
      debugShowCheckedModeBanner: false,
    );
  }
}
