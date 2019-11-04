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
    if (newpriorty <= 1 && newpriorty <= 2) {
      this._priorty = newpriorty;
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

    map["title"] = _title;
    map["description"] = _description;
    map["date"] = _date;
    map["priorty"] = _priorty;
    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priorty = map['priority'];
    this._date = map['date'];
  }
}
