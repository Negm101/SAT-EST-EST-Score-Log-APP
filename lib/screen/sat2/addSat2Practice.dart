import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_log_app/model/sat2/scoreIIPractice.dart';
import 'package:score_log_app/services/database.dart';

class AddSAT2Practice extends StatefulWidget {
  final ScoreIIPractice score;
  AddSAT2Practice(this.score);
  @override
  State<StatefulWidget> createState() {
    return _AddSAT2PracticeState(this.score);
  }
}

class _AddSAT2PracticeState extends State<AddSAT2Practice> {
  _AddSAT2PracticeState(this.score);
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController _scoreController = new TextEditingController();
  TextEditingController _subjectNameController = new TextEditingController();
  TextEditingController _scoreDateController = new TextEditingController();
  TextEditingController _noteController = new TextEditingController();
  int _state = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();
  ScoreIIPractice score;

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
                                labelText: "Score",
                                hintText: "/100",
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
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: new TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Subject",
                                counterText: '',
                                //errorText: validateScore(value),
                              ),
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              controller: _subjectNameController,
                              onChanged: (String value) {
                                setSubjectName();
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: new TextField(
                          decoration: const InputDecoration(
                              labelText: "Note", hintText: 'type a simple note', errorMaxLines: 32),
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
                          autocorrect: false,
                          validator: validateDate,
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
    }else if(_state == 2){
      return Icon(
        Icons.error,
        color: Colors.white,
        size: 30,
      );
    }
    else {
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
  void setScore(){
    score.score = int.parse(_scoreController.text);
  }
  void setSubjectName(){
    score.subject = _subjectNameController.text;
  }
  void setDate(){
    score.date = _scoreDateController.text;
  }
  void setNote(){
    score.note = _noteController.text;
  }
  void _save() async {
    if(_formKey.currentState.validate()){
      await databaseHelper.insertScoreSatIIPractice(score);
      Navigator.pop(context);
    }
    else {
      debugPrint('error');
    }
  }
  String validateScore(String value) {
    if (value.length == 0){
      debugPrint('value length: ' + value.length.toString());
      return "Field can\'t be empty";
    }
    else if (int.parse(value.toString()) > 100) {
      debugPrint('value: ' + value.toString() );
      return "Must be less than 800";
    }
    else {
      return null;
    }
  }
  String validateDate(String date){
    debugPrint('date: ' + date.length.toString());
    if(date.length == 0){
      debugPrint('date.length == 0');
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
}
