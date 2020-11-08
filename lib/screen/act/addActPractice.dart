import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:intl/intl.dart';
import 'package:score_log_app/model/act/actPractice.dart';
import 'package:score_log_app/services/database.dart';
import 'package:score_log_app/services/generalVar.dart';

class AddActPractice extends StatefulWidget {
  final ActPractice score;

  AddActPractice(this.score);

  @override
  State<StatefulWidget> createState() {
    return _AddActPracticeState(this.score);
  }
}

class _AddActPracticeState extends State<AddActPractice> {
  _AddActPracticeState(this.score);

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController _englishScoreController = new TextEditingController();
  TextEditingController _mathScoreController = new TextEditingController();
  TextEditingController _readingScoreController = new TextEditingController();
  TextEditingController _scienceScoreController = new TextEditingController();
  TextEditingController _noteController = new TextEditingController();
  TextEditingController _scoreDateController = new TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  int _state = 0;

  DatabaseHelper databaseHelper = DatabaseHelper();
  ActPractice score;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: Text(
            'Add Score (practice)',
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
                  margin: EdgeInsets.only(left: getWidthSize(0.05), right: getWidthSize(0.05)),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: new TextFormField(
                              decoration: const InputDecoration(
                                labelText: "English",
                                hintText: "/75",
                                counterText: '',
                              ),
                              validator: valEnglish,
                              autocorrect: false,
                              keyboardType: TextInputType.phone,
                              maxLength: 2,
                              controller: _englishScoreController,
                              onChanged: (String value) {
                                setEnglishScore();
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: new TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Math",
                                hintText: '/60',
                                counterText: '',
                              ),
                              validator: valMath,
                              autocorrect: false,
                              keyboardType: TextInputType.phone,
                              controller: _mathScoreController,
                              maxLength: 2,
                              onChanged: (String value) {
                                setMathScore();
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: new TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Reading",
                                hintText: "/40",
                                counterText: '',
                              ),
                              validator: valReading,
                              autocorrect: false,
                              keyboardType: TextInputType.phone,
                              maxLength: 2,
                              controller: _readingScoreController,
                              onChanged: (String value) {
                                setReadingScore();
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: new TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Science",
                                hintText: '/40',
                                counterText: '',
                              ),
                              validator: valScience,
                              autocorrect: false,
                              maxLength: 2,
                              keyboardType: TextInputType.phone,
                              controller: _scienceScoreController,
                              onChanged: (String value) {
                                setScienceScore();
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: new TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Note",
                              hintText: 'type a simple note'),
                          autocorrect: false,
                          maxLength: 32,
                          controller: _noteController,
                          onChanged: (String value) {
                            setNote();
                          },
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          validator: validateDate,
                          readOnly: true,
                          controller: _scoreDateController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
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
          color: MyColors.primary(),
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
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
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

    Timer(Duration(milliseconds: 3300), () {
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
  void setEnglishScore(){
    score.englishScore = int.parse(_englishScoreController.text);
  }
  void setMathScore(){
    score.mathScore = int.parse(_mathScoreController.text);
  }
  void setReadingScore(){
    score.readingScore = int.parse(_readingScoreController.text);
  }
  void setScienceScore(){
    score.scienceScore = int.parse(_scienceScoreController.text);
  }
  void setDate(){
    score.date = _scoreDateController.text;
  }
  void setNote(){
    score.note = _noteController.text;
  }
  String valEnglish(String value) {
    if (value.length == 0){
      return "Field can\'t be empty";
    }
    else if (int.parse(value.toString()) > 75) {
      return "At most 75";
    }
    else {
      return null;
    }
  }
  String valMath(String value) {
    if (value.length == 0){
      return "Field can\'t be empty";
    }
    else if (int.parse(value.toString()) > 60) {
      return "At most 60";
    }
    else {
      return null;
    }
  }
  String valReading(String value) {
    if (value.length == 0){
      return "Field can\'t be empty";
    }
    else if (int.parse(value.toString()) > 40) {
      return "At most 40";
    }
    else {
      return null;
    }
  }
  String valScience(String value) {
    if (value.length == 0){
      return "Field can\'t be empty";
    }
    else if (int.parse(value.toString()) > 40) {
      return "At most 40";
    }
    else {
      return null;
    }
  }
  String validateDate(String date){
    if(date.length == 0){
      return "Field can\'t be empty";
    }
    return null;
  }
  String validateNote(String note){
    if (note.length > 32){
      return "At most 32 characters";
    }
    else {
      return null;
    }
  }

  void _save() async {
    if(_formKey.currentState.validate()){
      setDate();
      await databaseHelper.insertScoreActPractice(score);
      Navigator.pop(context);
    }
    else {
    }
  }

  showPickerDate(BuildContext context) {
    Picker(
        hideHeader: false,
        adapter: DateTimePickerAdapter(
          minValue: DateTime(2000, 1, 1),
          maxValue: DateTime.now(),
        ),
        headercolor: MyColors.primary(),
        cancelTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold),
        confirmTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold),
        selectedTextStyle: TextStyle(color: MyColors.primary()),
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
