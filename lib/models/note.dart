import 'dart:io';

class Note{
  final int id;
  final String title, description;
  final File image;
  final DateTime dateTime;
  final bool status;

  Note(this.id, this.title, this.description, this.image, this.dateTime,
      this.status);
}