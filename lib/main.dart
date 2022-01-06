import 'package:flutter/material.dart';
import 'package:visual_notes/screens/add_notes_screen.dart';

import './screens/notes_list_screen.dart';

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
      home: NotesListScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        AddNotesScreen.routeName: (ctx) => AddNotesScreen(),
      },
    );
  }
}
