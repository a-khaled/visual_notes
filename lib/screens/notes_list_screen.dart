import 'package:flutter/material.dart';

import './add_notes_screen.dart';

class NotesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visual Notes'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () {
            Navigator.of(context ).pushNamed(AddNotesScreen.routeName);
          }),
        ],
      ),
        body: Center(child: Text('No Notes yet, start adding some!')));
  }
}
