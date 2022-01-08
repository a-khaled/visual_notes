import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../screens/edit_note_screen.dart';
import '../screens/notes_list_screen.dart';
import '../providers/visual_notes.dart';

class NoteItem extends StatefulWidget {
  final String id, title, description, dateTime, status;
  final File image;

  NoteItem(this.id, this.title, this.description, this.dateTime, this.status,
      this.image);

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  void _deleteNote() {
    Provider.of<VisualNotes>(context, listen: false).deleteNote(widget.id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            child: widget.image != null
                ? Image.file(
                    widget.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Text(
                    'No Image Available',
                    textAlign: TextAlign.center,
                  ),
            alignment: Alignment.center,
          ),
          Column(children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.dateTime,
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 130,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blue),
                borderRadius: BorderRadius.all((Radius.circular(10)))
              ),
              child: Text(
                widget.description,
                textAlign: TextAlign.center,
              ),
            ),
          ]),
          Container(
            margin: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pushNamed(
                      context, EditNoteScreen.routeName,
                      arguments: {'id': widget.id}),
                  child: Text(
                    'Edit Note',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                ),
                TextButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title:
                              Text('Are you sure you want to delete this note ?'),
                          actions: [
                            ElevatedButton(
                                onPressed: _deleteNote, child: Text('Yes')),
                            ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('No')),
                          ],
                        );
                      }),
                  child: Text(
                    'Delete Note',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
