import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import 'package:visual_notes/screens/add_notes_screen.dart';
import './screens/notes_list_screen.dart';
import './providers/visual_notes.dart';
import './screens/edit_note_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: VisualNotes(),
      child: MaterialApp(
        title: 'Visual notes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NotesListScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          NotesListScreen.routeName: (ctx) => NotesListScreen(),
          AddNotesScreen.routeName: (ctx) => AddNotesScreen(),
          EditNoteScreen.routeName: (ctx) => EditNoteScreen(),
        },
      ),
    );
  }
}
