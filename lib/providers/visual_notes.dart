import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../models/note.dart';
import '../helpers/db_helper.dart';

class VisualNotes with ChangeNotifier {
  List<Note> _items = [];

  List<Note> get items {
    return [..._items];
  }

  void addNote(String id, String title, String description, String dateTime,
      File image, String status) {
    final newNote = Note(id, title, description, image, dateTime, status);
    _items.add(newNote);
      DBHelper.insert('notes', {
        'id': newNote.id,
        'title': newNote.title,
        'description': newNote.description,
        'dateTime': newNote.dateTime,
        'status': newNote.status,
        'image': newNote.image.path
      });
    notifyListeners();
  }

  Future<void> fetchAndSetNotes() async {
      final dataList = await DBHelper.getData('notes');
      _items = _items + dataList
          .map((item) => Note(item['id'], item['title'], item['description'],
              File(item['image']), item['dateTime'], item['status']))
          .toList();
    notifyListeners();
  }

  Future<Note> fetchNote(String id) async {
    final dataEntry = await DBHelper.getEntry('notes', id);
    List<Note> notes = dataEntry
        .map((item) => Note(item['id'], item['title'], item['description'],
        File(item['image']), item['dateTime'], item['status']))
        .toList();
    return notes[0];
  }

  void editNote(String id, String title, String description, String dateTime,
      File image, String status) {
    final newNote = Note(id, title, description, image, dateTime, status);
    DBHelper.update('notes', id, {
      'id': newNote.id,
      'title': newNote.title,
      'description': newNote.description,
      'dateTime': newNote.dateTime,
      'status': newNote.status,
      'image': newNote.image.path
    });
    notifyListeners();
  }
  void deleteNote(String id) {
    DBHelper.delete('notes', id);
  }

}
