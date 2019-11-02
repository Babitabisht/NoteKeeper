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

  set date(String new_date) {
    this._date = new_date;
  }
}
