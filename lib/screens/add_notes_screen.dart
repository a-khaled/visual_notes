import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../providers/visual_notes.dart';


class AddNotesScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddNotesScreenState createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  String dateDisplayed, timeDisplayed, status;
  File _pickedImage;
  int singleId = 0;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _saveNote() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty || _pickedImage == null || dateDisplayed == null || timeDisplayed == null || status == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill out all fields"),));
      return;
    }
    Provider.of<VisualNotes>(context, listen: false).addNote(UniqueKey().toString(), _titleController.text, _descriptionController.text, '$dateDisplayed $timeDisplayed', _pickedImage, status);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: _selectedDate == null ? DateTime.now() : _selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        dateDisplayed = DateFormat.yMd().format(_selectedDate);
      });
    });
  }

  void _presentTimePicker() {
    showTimePicker(
      context: context,
      initialTime:
          _selectedTime == null ? TimeOfDay(hour: 9, minute: 0) : _selectedTime,
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        _selectedTime = pickedTime;
        timeDisplayed =
            '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')} ${_selectedTime.period == DayPeriod.am ? 'Am' : 'Pm'}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add a new note'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Title',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)))),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)))),
                      controller: _descriptionController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(dateDisplayed == null
                            ? 'No date chosen!'
                            : 'Picked Date: $dateDisplayed'),
                        TextButton(
                            onPressed: _presentDatePicker,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Text(timeDisplayed == null
                            ? 'No Time chosen!'
                            : 'Picked Time: $timeDisplayed'),
                        TextButton(
                            onPressed: _presentTimePicker,
                            child: Text(
                              'Choose Time',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Status: ',
                          style: TextStyle(fontSize: 15),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text('Open'),
                            value: 'Open',
                            groupValue: status,
                            onChanged: (value) {
                              setState(() {
                                status = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text('Closed'),
                            value: 'Closed',
                            groupValue: status,
                            onChanged: (value) {
                              setState(() {
                                status = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    ImageInput(_selectImage),
                  ],
                ),
              )),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Add Note'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                elevation: MaterialStateProperty.all(0),
              ),
              onPressed: _saveNote,
            ),
          ],
        ));
  }
}
