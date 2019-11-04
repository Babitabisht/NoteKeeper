import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_keeper/models/note.dart';
import 'package:note_keeper/utils/database_helper.dart';

class NoteDetails extends StatefulWidget {
  final String appBarTitle;
  final Note note;
  NoteDetails(this.note, this.appBarTitle);

  @override
  _NoteDetailsState createState() =>
      _NoteDetailsState(this.note, this.appBarTitle);
}

class _NoteDetailsState extends State<NoteDetails> {
  String appBarTitle;
  Note note;
  static var _priorties = ["High", "Low"];
  DatabaseHelper helper = DatabaseHelper();
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  _NoteDetailsState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    t1.text = note.title;
    t2.text = note.description;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: moveToLastScreen(),
        // ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: DropdownButton(
                items: _priorties.map((String dropdownItem) {
                  return DropdownMenuItem<String>(
                      value: dropdownItem, child: Text(dropdownItem));
                }).toList(),
                style: textStyle,
                value: changeToString(note.priorty),
                onChanged: (value) {
                  setState(() {
                    debugPrint(" ss clicked $value");

                    changeToInt(value);
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: t1,
                style: textStyle,
                onChanged: (value) {
                  updateTitle();
                  debugPrint(value);
                },
                decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: t2,
                style: textStyle,
                onChanged: (value) {
                  updateDescription();
                  debugPrint(value);
                },
                decoration: InputDecoration(
                    labelText: "Discription",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: Text(
                        "Save",
                        textScaleFactor: 1.5,
                      ),
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        _save();
                        //debugPrint(value);
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Text(
                        "Delete",
                        textScaleFactor: 1.5,
                      ),
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        _delete();
                        //debugPrint(value);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  moveToLastScreen() {
    Navigator.pop(context, true);
  }

  changeToInt(String prior) {
    switch (prior) {
      case "High":
        note.priorty = 1;
        break;
      case "Low":
        note.priorty = 2;
        break;
    }
  }

  changeToString(int prior) {
    String priority;
    switch (prior) {
      case 1:
        priority = "High";
        break;
      case 2:
        priority = "Low";
        break;
    }
    return priority;
  }

  updateTitle() {
    note.title = t1.text;
  }

  updateDescription() {
    note.description = t2.text;
  }

  _save() async {
    moveToLastScreen();
    debugPrint("In save method");

    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      result = await helper.updateNote(note);
    } else {
      result = await helper.insertNote(note);
    }

    debugPrint("after save method $result");

    if (result == 0) {
      _showAlert("status", "Not saved !");
    } else {
      _showAlert("status", "saved successfully");
    }
  }

  _showAlert(String title, String message) {
    AlertDialog dialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => dialog);
  }

  _delete() async {
    moveToLastScreen();

    if (note.id == null) {
      _showAlert("Status", "No note available to be deleted");
    }

    int result = await helper.deleteNote(note.id);

    if (result != 0) {
      _showAlert("Status", "Note deleted successfully !");
    } else {
      _showAlert("Status", "Not Deleted yet, try Again !");
    }
  }
}
