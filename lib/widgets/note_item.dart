import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class NoteItem extends StatelessWidget {
  final String id, title, description, dateTime, status;
  final File image;

  NoteItem(this.id, this.title, this.description, this.dateTime, this.status,
      this.image);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: image != null
                ? Image.file(
                    image,
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
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            Text(dateTime),
            Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
              ),
              child: Text(description),
            ),
          ]),
          Column(children: [
            TextButton(onPressed: () {}, child: Text('Edit Note', style: TextStyle(color: Colors.white),), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue),),),
            TextButton(onPressed: () {}, child: Text('Delete Note', style: TextStyle(color: Colors.white),), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),
          ],),
        ],
      ),
    );
  }
}
