import 'package:flutter/material.dart';

class NoteDetails extends StatefulWidget {
  String appBarTitle;

  NoteDetails(this.appBarTitle);

  @override
  _NoteDetailsState createState() => _NoteDetailsState(this.appBarTitle);
}

class _NoteDetailsState extends State<NoteDetails> {
  String appBarTitle;

  static var _priorties = ["High", "Low"];
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  _NoteDetailsState(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return WillPopScope(
      onWillPop: (){
        moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: moveToLastScreen(),
          ),
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
                  value: "Low",
                  onChanged: (value) {
                    setState(() {
                      debugPrint(" ss clicked $value");
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
      ),
    );
  }

  moveToLastScreen() {
    Navigator.pop(context);
  }
}
