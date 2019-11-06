import 'package:flutter/material.dart';

import 'package:note_keeper/models/note.dart';
import 'package:note_keeper/screens/note_details.dart';
import 'package:note_keeper/utils/database_helper.dart';
import 'package:sqflite/sqlite_api.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  List<Note> noteList;
  var count;
  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      debugPrint("yes empty");

      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Note List"),
      ),
      body: getNoteList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("pressing FAB");
          navigateToDetails(Note("", 1, ""), "Add");
        },
        tooltip: "Add note",
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteList() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: noteList == null ? 0 : noteList.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  getPriorityColor(this.noteList[position].priorty),
              child: (getPriorityIcon(this.noteList[position].priorty)),
            ),
            title: Text(this.noteList[position].title, style: titleStyle),
            subtitle: Text(this.noteList[position].date),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _delete_note(context, this.noteList[position]);
              },
            ),
            onTap: () {
              debugPrint("tapped");
              navigateToDetails(this.noteList[position], "Edit Notes");
            },
          ),
        );
      },
    );
  }

  void _delete_note(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);

    if (result != 0) {
      _showSnackBar(context, "deleted successfully");
    }
    updateListView();
  }

  _showSnackBar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));

    Scaffold.of(context).showSnackBar(snackbar);
  }

  Color getPriorityColor(int priorty) {
    print("priority is $priorty");
    switch (priorty) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.greenAccent;
    }
  }

  Icon getPriorityIcon(int prio) {
    switch (prio) {
      case 1:
        return Icon(Icons.arrow_back);
        break;
      case 2:
        return Icon(Icons.arrow_drop_up);
        break;
      default:
        return Icon(Icons.arrow_back);
    }
  }

  navigateToDetails(Note note, String title) async {
    var a = note.priorty;
    debugPrint("navigateToDetails ....$a");

    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      debugPrint("title, $title");

      return NoteDetails(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  updateListView() {
    print("dddddddddddd");
    //  DatabaseHelper databaseHelper = DatabaseHelper();

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((notes) => {
            setState(() {

              this.noteList = notes;
              var a = notes[0].priorty;
              debugPrint("Note in updateListView , $a");

              this.count = notes.length;
            })
          });
    });
  }
}
