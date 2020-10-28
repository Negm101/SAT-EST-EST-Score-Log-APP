import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_log_app/model/act/actReal.dart';
import 'package:score_log_app/services/database.dart';

class AddActReal extends StatefulWidget {
  final ActReal score;
  AddActReal(this.score);
  @override
  State<StatefulWidget> createState() {
    return _AddActRealState(this.score);
  }
}

class _AddActRealState extends State<AddActReal> {
  _AddActRealState(this.score);
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController _englishScoreController = new TextEditingController();
  TextEditingController _mathScoreController = new TextEditingController();
  TextEditingController _readingScoreController = new TextEditingController();
  TextEditingController _scienceScoreController = new TextEditingController();
  TextEditingController _noteController = new TextEditingController();
  TextEditingController _scoreDateController = new TextEditingController();
  int _state = 0;

  DatabaseHelper databaseHelper = DatabaseHelper();
  ActReal score;
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
                                hintText: "/36",
                                counterText: '',
                              ),
                              validator: valScore,
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
                                hintText: '/36',
                                counterText: '',
                              ),
                              validator: valScore,
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
                                hintText: "/36",
                                counterText: '',
                              ),
                              validator: valScore,
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
                                hintText: '/36',
                                counterText: '',
                              ),
                              validator: valScore,
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
                        child: new TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Note", hintText: 'type a simple note'),
                          autocorrect: false,
                          maxLength: 32,
                          controller: _noteController,
                          onChanged: (String value) {
                            setNote();
                          },
                        ),
                      ),
                      Container(
                        child: new TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Date of taking the test",
                            errorStyle: TextStyle(
                              color: Colors.red, // or any other color
                            ),
                          ),
                          validator: validateDate,
                          autocorrect: false,
                          enabled: false,
                          controller: _scoreDateController,
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
          height: getHeightSize(.34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: CupertinoDatePicker(
                  minimumDate: DateTime(2000),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime dateTime) {
                    setState(() {
                      _scoreDateController.value = TextEditingValue(text: dateTime.toString());
                      setDate();
                    });
                    print("dateTime: $dateTime");
                  },
                ),
              ),
              Container(
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

            ],
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
    debugPrint('reading score: ' + score.englishScore.toString());
  }
  void setMathScore(){
    score.mathScore = int.parse(_mathScoreController.text);
    debugPrint('writing score: ' + score.mathScore.toString());
  }
  void setReadingScore(){
    score.readingScore = int.parse(_readingScoreController.text);
    debugPrint('math no calc score: ' + score.readingScore.toString());
  }
  void setScienceScore(){
    score.scienceScore = int.parse(_scienceScoreController.text);
    debugPrint('math calc score: ' + score.scienceScore.toString());
  }
  void setDate(){
    score.date = _scoreDateController.text;
  }
  void setNote(){
    score.note = _noteController.text;
  }
  String valScore(String value) {
    if (value.length == 0){
      debugPrint('value length: ' + value.length.toString());
      return "Field can\'t be empty";
    }
    else if (int.parse(value.toString()) > 36) {
      debugPrint('value: ' + value.toString() );
      return "Must be less than 36";
    }
    else {
      return null;
    }
  }
  String validateDate(String date){
    debugPrint('date: ' + date.length.toString());
    if(date.length == 0){
      debugPrint('date.length == ${date.length}');
      return "Field can\'t be empty";
    }
    debugPrint('null');
    return null;
  }
  String validateNote(String note){
    if (note.length > 32){
      debugPrint('note length: ' + note.length.toString());
      return "Characters must be less than 32";
    }
    else {
      return null;
    }
  }

  void _save() async {
    if(_formKey.currentState.validate()){
      await databaseHelper.insertScoreActReal(score);
      debugPrint('reading: ' + _englishScoreController.text);
      debugPrint('writing: ' + _mathScoreController.text);
      debugPrint('math: ' + _readingScoreController.text);
      debugPrint('math(calc) : ' + _scienceScoreController.text);
      debugPrint('date: ' + _scoreDateController.text);
      Navigator.pop(context);
    }
    else {
      debugPrint('error at save practice');
    }
  }
}