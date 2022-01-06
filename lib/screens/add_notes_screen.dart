import 'package:flutter/material.dart';

class AddNotesScreen extends StatelessWidget {
  static const routeName = '/add-place';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add a new note'),
        ),
        body: Center(
          child: Text('add a new note'),
        ));
  }
}
