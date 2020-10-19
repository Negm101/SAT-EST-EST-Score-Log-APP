import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_log_app/model/scoreSAT1.dart';
import 'package:score_log_app/services/database.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import '../models/user.dart';

class AddSAT1 extends StatefulWidget {
  final ScoreI scoreI;
  AddSAT1(this.scoreI);
  @override
  _AddSAT1State createState() => new _AddSAT1State();
}

class _AddSAT1State extends State<AddSAT1> {
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
  final TextEditingController _englishScoreController =
      new TextEditingController();

  // String firstName = User.instance.first_name;
  final TextEditingController _mathScoreController =
      new TextEditingController();
  final TextEditingController _noteController = new TextEditingController();
  final TextEditingController _scoreTypeController =
      new TextEditingController();
  TextEditingController _scoreDateController = new TextEditingController();
  String scoreType = 'Practice';
  bool isPracticeSelected = true;
  bool isRealSelected = false;
  int _state = 0;



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
            'Add Score',
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
                                labelText: "English",
                                hintText: "/800",
                                counterText: '',
                              ),
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                              controller: _englishScoreController,
                              onChanged: (String value) {
                                // firstName = value;
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: new TextField(
                              decoration: const InputDecoration(
                                labelText: "Math",
                                hintText: '/800',
                                counterText: '',
                              ),
                              autocorrect: false,
                              controller: _mathScoreController,
                              onChanged: (String value) {
                                //lastName = value;
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
                            //lastName = value;
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
                          onChanged: (String value) {
                            //lastName = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5, top: 20),
                        child: Text(
                          'Type',
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ChoiceChip(
                            label: Text('Practice'),
                            padding: EdgeInsets.only(
                                left: getWidthSize(.135), right: getWidthSize(.135)),
                            selected: isPracticeSelected,
                            onSelected: (bool value) {
                              setState(() {
                                isRealSelected = false;
                                isPracticeSelected = true;
                                scoreType = 'Practice';
                                debugPrint(scoreType);
                              });
                            },
                          ),
                          ChoiceChip(
                            label: Text('  Real  '),
                            padding: EdgeInsets.only(
                                left: getWidthSize(.135), right: getWidthSize(.135)),
                            selected: isRealSelected,
                            onSelected: (bool value) {
                              setState(() {
                                isPracticeSelected = false;
                                isRealSelected = true;
                                scoreType = 'Real';
                                debugPrint(scoreType);
                              });
                            },
                          ),
                        ],
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
                      _scoreDateController.value = TextEditingValue(
                          text:
                          "${dateTime.day}-${dateTime.month}-${dateTime.year}");
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
}
