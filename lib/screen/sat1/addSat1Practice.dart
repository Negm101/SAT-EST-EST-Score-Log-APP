import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_log_app/model/scoreIPractice.dart';
import 'package:score_log_app/services/database.dart';
//TODO: FIX (MATH CLAC) AND WRITING NOT APPEARING IN LIST
class AddSAT1Practice extends StatefulWidget {
  final ScoreIPractice scoreI;
  AddSAT1Practice(this.scoreI);
  @override
  State<StatefulWidget> createState() {
    return _AddSAT1PracticeState(this.scoreI);
  }
}

class _AddSAT1PracticeState extends State<AddSAT1Practice> {
  _AddSAT1PracticeState(this.scoreI);
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController _readingScoreController = new TextEditingController();
  TextEditingController _writingScoreController = new TextEditingController();
  TextEditingController _mathNoCalcController = new TextEditingController();
  TextEditingController _mathCalcController = new TextEditingController();
  TextEditingController _noteController = new TextEditingController();
  TextEditingController _scoreDateController = new TextEditingController();
  int _state = 0;

  DatabaseHelper databaseHelper = DatabaseHelper();
  ScoreIPractice scoreI;
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
                                labelText: "Reading",
                                hintText: "/52",
                                counterText: '',
                              ),
                              validator: valReading,
                              autocorrect: false,
                              keyboardType: TextInputType.number,
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
                                labelText: "Writing",
                                hintText: '/44',
                                counterText: '',
                              ),
                              validator: valWriting,
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              controller: _writingScoreController,
                              maxLength: 2,
                              onChanged: (String value) {
                                setWritingScore();
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
                                labelText: "Math (no-calc)",
                                hintText: "/20",
                                counterText: '',
                              ),
                              validator: valMathNoCalc,
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              controller: _mathNoCalcController,
                              onChanged: (String value) {
                                setMathNoCalcScore();
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: new TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Math (calc)",
                                hintText: '/38',
                                counterText: '',
                              ),
                              validator: valMathClac,
                              autocorrect: false,
                              maxLength: 2,
                              keyboardType: TextInputType.number,
                              controller: _mathCalcController,
                              onChanged: (String value) {
                                setMathCalcScore();
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
  void setReadingScore(){
    scoreI.readingScore = int.parse(_readingScoreController.text);
  }
  void setWritingScore(){
    scoreI.writingScore = int.parse(_writingScoreController.text);
  }
  void setMathNoCalcScore(){
    scoreI.mathNoCalcScore = int.parse(_mathNoCalcController.text);
  }
  void setMathCalcScore(){
    scoreI.mathCalcScore = int.parse(_mathCalcController.text);
  }
  void setDate(){
    scoreI.date = _scoreDateController.text;
  }
  void setNote(){
    scoreI.note = _noteController.text;
  }
  String valReading(String value) {
    if (value.length == 0){
      debugPrint('value length: ' + value.length.toString());
      return "Field can\'t be empty";
    }
    else if (int.parse(value.toString()) > 52) {
      debugPrint('value: ' + value.toString() );
      return "Must be less than 52";
    }
    else {
      return null;
    }
  }
  String valWriting(String value) {
    if (value.length == 0){
      debugPrint('value length: ' + value.length.toString());
      return "Field can\'t be empty";
    }
    else if (int.parse(value.toString()) > 44) {
      debugPrint('value: ' + value.toString() );
      return "Must be less than 44";
    }
    else {
      return null;
    }
  }
  String valMathNoCalc(String value) {
    if (value.length == 0){
      debugPrint('value length: ' + value.length.toString());
      return "Field can\'t be empty";
    }
    else if (int.parse(value.toString()) > 20) {
      debugPrint('value: ' + value.toString() );
      return "Must be less than 20";
    }
    else {
      return null;
    }
  }
  String valMathClac(String value) {
    if (value.length == 0){
      debugPrint('value length: ' + value.length.toString());
      return "Field can\'t be empty";
    }
    else if (int.parse(value.toString()) > 38) {
      debugPrint('value: ' + value.toString() );
      return "Must be less than 38";
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
      await databaseHelper.insertScoreSatIPractice(scoreI);
      debugPrint('reading: ' + _readingScoreController.text);
      debugPrint('writing: ' + _writingScoreController.text);
      debugPrint('math: ' + _mathNoCalcController.text);
      debugPrint('math(calc) : ' + _mathCalcController.text);
      debugPrint('date: ' + _scoreDateController.text);
    }
    else {
      debugPrint('error');
    }
  }
}
