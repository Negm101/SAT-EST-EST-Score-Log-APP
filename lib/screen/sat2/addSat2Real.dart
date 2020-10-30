import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:score_log_app/model/sat2/scoreIIReal.dart';
import 'package:score_log_app/services/database.dart';

class AddSAT2Real extends StatefulWidget {
  final ScoreIIReal score;

  AddSAT2Real(this.score);

  @override
  State<StatefulWidget> createState() {
    return _AddSAT2RealState(this.score);
  }
}

class _AddSAT2RealState extends State<AddSAT2Real> {
  _AddSAT2RealState(this.score);

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController _scoreController = new TextEditingController();
  TextEditingController _scoreDateController = new TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  TextEditingController _noteController = new TextEditingController();
  TextEditingController _subjectNameController =
      TextEditingController(text: 'Math Level 1');
  int _state = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();
  ScoreIIReal score;
  final subjects = [
    "Math Level 1",
    "Math Level 2",
    "Biology E",
    'Biology M',
    'Literature',
    'US History',
    'World History',
    'Chemistry',
    'Physics',
    'French',
    'German',
    'Spanish',
    'Italian',
    'Latin',
    'Chinese',
    'Japanese',
    'Korean'
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: Text(
            'Add Score (real)',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          actions: <Widget>[
            new Container(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
            )
          ]),
      body: new Form(
          key: _formKey,
          child: Container(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: getWidthSize(0.05), right: getWidthSize(0.05)),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: new TextFormField(
                          decoration: const InputDecoration(
                            //border: OutlineInputBorder(),
                            labelText: "Score",
                            hintText: "/800",
                            counterText: '',
                          ),
                          validator: validateScore,
                          autocorrect: false,
                          keyboardType: TextInputType.phone,
                          maxLength: 4,
                          controller: _scoreController,
                          onChanged: (String value) {
                            setScore();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: new TextField(
                          decoration: const InputDecoration(
                              //border: OutlineInputBorder(),
                              labelText: "Note",
                              hintText: 'type a simple note',
                              errorMaxLines: 32),
                          autocorrect: false,
                          maxLength: 32,
                          controller: _noteController,
                          onChanged: (String value) {
                            setNote();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: TextFormField(
                          validator: validateDate,
                          readOnly: true,
                          controller: _subjectNameController,
                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                            border: OutlineInputBorder(),
                            //labelText: 'Subject',
                            hintText: _subjectNameController.text,
                            suffixIcon: Icon(Icons.subject),
                          ),
                          onTap: () {
                            showPickerSubject(context);
                          },
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          validator: validateDate,
                          readOnly: true,
                          controller: _scoreDateController,
                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                            border: OutlineInputBorder(),
                            //labelText: 'Date',
                            hintText: 'Date of taking the test',
                            suffixIcon: Icon(Icons.date_range),
                          ),
                          onTap: () {
                            showPickerDate(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,
          child: FlatButton(
            child: setUpButtonChild(),
            onPressed: () {
              setState(() {
                _save();
              });
            },
          ),
        ),
      ),
    );
  }

/*

 */
  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "ADD",
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      );
    } else if (_state == 1) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 4,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else if (_state == 2) {
      return Icon(
        Icons.error,
        color: Colors.white,
        size: 30,
      );
    } else {
      return Icon(
        Icons.check,
        color: Colors.white,
        size: 30,
      );
    }
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        _state = 2;
      });
    });
  }

  double getWidthSize(double factor) {
    return MediaQuery.of(context).size.width * factor;
  }

  double getHeightSize(double factor) {
    return MediaQuery.of(context).size.height * factor;
  }

  void setScore() {
    score.score = int.parse(_scoreController.text);
  }

  void setSubjectName() {
    score.subject = _subjectNameController.text;
  }

  void setDate() {
    score.date = _scoreDateController.text;
  }

  void setNote() {
    score.note = _noteController.text;
  }

  void _save() async {
    if (_formKey.currentState.validate()) {
      setSubjectName();
      setDate();
      await databaseHelper.insertScoreSatIIReal(score);
      Navigator.pop(context);
    } else {
      debugPrint('error');
    }
  }

  String validateScore(String value) {
    if (value.length == 0) {
      debugPrint('value length: ' + value.length.toString());
      return "Field can\'t be empty";
    } else if (int.parse(value.toString()) > 800) {
      debugPrint('value: ' + value.toString());
      return "At most 800";
    } else if (int.parse(value.toString()) < 200) {
      debugPrint('value: ' + value.toString());
      return "At least 200";
    }
    else {
      return null;
    }
  }

  String validateDate(String date) {
    debugPrint('date: ' + date.length.toString());
    if (date.length == 0) {
      debugPrint('date.length == 0');
      return "Field can\'t be empty";
    }
    debugPrint('null');
    return null;
  }

  String validateNote(String note) {
    if (note.length > 32) {
      debugPrint('note length: ' + note.length.toString());
      return "At most 32 characters";
    } else {
      return null;
    }
  }

  showPickerSubject(BuildContext context) {
    new Picker(
        adapter: PickerDataAdapter<String>(pickerdata: subjects),
        changeToFirst: true,
        hideHeader: false,
        headercolor: Colors.blue,
        cancelTextStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        confirmTextStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        onConfirm: (Picker picker, List value) {
          setState(() {
            _subjectNameController.text = picker.adapter.text
                .toString()
                .replaceAll("[", "")
                .replaceAll(']', '');
            setSubjectName();
          });
        }).showModal(this.context); //_scaffoldKey.currentState);
  }

  showPickerDate(BuildContext context) {
    Picker(
        hideHeader: false,
        adapter: DateTimePickerAdapter(
          minValue: DateTime(2000, 1, 1),
          maxValue: DateTime.now(),
        ),
        headercolor: Colors.blue,
        cancelTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold),
        confirmTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          var date = (picker.adapter as DateTimePickerAdapter).value;
          _scoreDateController.text = getDateFormat(date);
          setDate();
        }).showModal(context);
  }

  String getDateFormat(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
