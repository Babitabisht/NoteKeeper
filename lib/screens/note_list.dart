import 'package:flutter/material.dart';
import 'package:note_keeper/screens/note_details.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  var count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note List"),
      ),
      body: getNoteList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("pressing FAB");
          navigateToDetails("Add");
        },
        tooltip: "Add note",
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteList() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.limeAccent,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.greenAccent,
              child: Icon(Icons.keyboard_arrow_left),
            ),
            title: Text("Dummy title", style: titleStyle),
            subtitle: Text("Dummy Date"),
            trailing: Icon(
              Icons.delete,
              color: Colors.grey,
            ),
            onTap: () {
              debugPrint("tapped");
              navigateToDetails("Edit Notes");
            },
          ),
        );
      },
    );
  }

  navigateToDetails(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      debugPrint("title, $title");
      
      return NoteDetails(title);
    }));
  }
}
