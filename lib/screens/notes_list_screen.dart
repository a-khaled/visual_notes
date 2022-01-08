import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_notes_screen.dart';
import '../providers/visual_notes.dart';
import '../widgets/note_item.dart';

class NotesListScreen extends StatefulWidget {
  static const routeName = '/edit-note';

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visual Notes'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddNotesScreen.routeName);
              }),
        ],
      ),
      body: FutureBuilder(
        future:
        Provider.of<VisualNotes>(context, listen: false).fetchAndSetNotes(),
        builder: (ctx, snapshot) =>
        snapshot.connectionState ==
            ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<VisualNotes>(
            child: Center(
              child: Text('Got no notes yet, start adding some!'),
            ),
            builder: (ctx, visualNotes, ch) =>
            visualNotes.items.length <= 0
                ? ch
                : ListView.builder(
                itemCount: visualNotes.items.length,
                itemBuilder: (ctx, i) =>
                    NoteItem(
                        visualNotes.items[i].id,
                        visualNotes.items[i].title,
                        visualNotes.items[i].description,
                        visualNotes.items[i].dateTime,
                        visualNotes.items[i].status,
                        visualNotes.items[i].image)
            )
        ),
      ),
    );
  }
}
