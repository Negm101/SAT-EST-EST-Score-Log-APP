import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_log_app/model/scoreIPractice.dart';
import 'package:score_log_app/model/scoreIReal.dart';
import 'package:score_log_app/services/database.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import '../models/user.dart';
// TODO: finish this class
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
/*
  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      showInSnackBar('snackchat');
      User.instance.first_name = firstName;
      User.instance.last_name = lastName;

      User.instance.save().then((result) {
        print("Saving done: ${result}.");
      });
    }
  }*/

  // controllers for form text controllers
  TextEditingController _readingScoreController = new TextEditingController();
  TextEditingController _writingScoreController = new TextEditingController();
  TextEditingController _mathNoCalcController = new TextEditingController();
  TextEditingController _mathCalcController = new TextEditingController();
  TextEditingController _noteController = new TextEditingController();
  TextEditingController _scoreDateController = new TextEditingController();
  String scoreType = 'Practice';
  bool isPracticeSelected = true;
  bool isRealSelected = false;
  int _state = 0;

  DatabaseHelper databaseHelper = DatabaseHelper();
  ScoreIPractice scoreI;
  @override
  /*void initState() {
    _firstNameController.text = firstName;
    _lastNameController.text = lastName;
    return super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final DateTime today = new DateTime.now();
    Timer(Duration(seconds: 5), () {
      // 5s over, navigate to a new page
    });
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
          //autovalidateMode: _autovalidate,
          //onWillPop: _warnUserAboutInvalidData,
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
                            child: new TextField(
                              decoration: const InputDecoration(
                                labelText: "Reading",
                                hintText: "/52",
                                counterText: '',
                                errorMaxLines: 2,
                              ),
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
                            child: new TextField(
                              decoration: const InputDecoration(
                                labelText: "Writing",
                                hintText: '/44',
                                counterText: '',
                              ),
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              controller: _writingScoreController,
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
                            child: new TextField(
                              decoration: const InputDecoration(
                                labelText: "Math (no-calc)",
                                hintText: "/20",
                                counterText: '',
                                errorMaxLines: 2,
                              ),
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
                            child: new TextField(
                              decoration: const InputDecoration(
                                labelText: "Math (calc)",
                                hintText: '/38',
                                counterText: '',
                              ),
                              autocorrect: false,
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
                        child: new TextField(
                          decoration: const InputDecoration(
                              labelText: "Note", hintText: 'type a simple note'),
                          autocorrect: false,
                          maxLength: 32,
                          controller: _noteController,
                          onChanged: (String value) {
                            
                          },
                        ),
                      ),
                      Container(
                        child: new TextField(
                          decoration: const InputDecoration(
                            labelText: "Date of taking the test",
                          ),
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
                      databaseHelper.insertScoreSatIPractice(scoreI);
                      animateButton();
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
  void setDateScore(){
    scoreI.date = _scoreDateController.text;
  }
  void setNoteScore(){
    scoreI.note = _mathNoCalcController.text;
  }

  void _save() async {
    int result;
    if (scoreI.id != null) {
      // Case 1: Update operation
      result = await databaseHelper.updateScoreSatIPractice(scoreI);
    } else {
      // Case 2: Insert Operation
      result = await databaseHelper.insertScoreSatIPractice(scoreI);
    }

    if (result != 0) {
      debugPrint('Inserted successfully');
    } else {
      // Failure
      debugPrint('error');
    }
  }
}
