class Note {
  int _id;
  String _title, _description, _date;
  int _priorty;

  Note(this._title, this._priorty, this._date, [this._description]);

  Note.withId(this._id, this._title, this._priorty, this._date,
      [this._description]);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priorty => _priorty;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDis) {
    if (newDis.length <= 255) {
      this._description = newDis;
    }
  }

  set priorty(int newpriorty) {
    print("In set method of priority $newpriorty");
    if (newpriorty >= 1 && newpriorty <= 2) {
      print("In set priority  ");
      this._priorty = newpriorty;
    } else {
      print("cant set priority");
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map["id"] = _id;
    }
    print(
        "id = $id, titile $title, description $description, priority $_priorty");

    map["title"] = _title;
    map["description"] = _description;
    map["date"] = _date;
    map["priorty"] = _priorty;
    print("priority....$map");
    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priorty = map['priorty'];
    this._date = map['date'];
  }
}
