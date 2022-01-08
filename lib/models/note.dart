import 'dart:io';

class Note{
  final String id, title, description, dateTime, status;
  final File image;

  Note(this.id, this.title, this.description, this.image, this.dateTime,
      this.status);
}