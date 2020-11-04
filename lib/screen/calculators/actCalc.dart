import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_log_app/services/calculators.dart';
import 'package:score_log_app/services/generalVar.dart';

class ActCalc extends StatefulWidget {
  final Calculators calculators;

  ActCalc(this.calculators);

  @override
  State<StatefulWidget> createState() {
    return _ActCalcState(this.calculators);
  }
}

class _ActCalcState extends State<ActCalc> {
  _ActCalcState(this.calculators);

  Calculators calculators;
  TextEditingController _englishController = new TextEditingController();
  TextEditingController _readingController = new TextEditingController();
  TextEditingController _mathController = new TextEditingController();
  TextEditingController _resultController =
      new TextEditingController(text: ' ');
  TextEditingController _resultSubjectsController =
      new TextEditingController(text: ' ');
  TextEditingController _compositeController =
      new TextEditingController(text: ' ');
  TextEditingController _actTextController = new TextEditingController();
  final _scrollController = ScrollController();
  final pageController = PageController(viewportFraction: 0.8);
  bool isPublicSelected = true;
  bool isPrivateSelected = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: Text(
            'ACT to SAT',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          actions: <Widget>[
            new Container(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
            )
          ]),
      body: ListView(
        controller: _scrollController,
        children: [
          Container(
            margin: EdgeInsets.only(
                left: getWidthSize(0.05), right: getWidthSize(0.05)),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 30),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Column(
                    children: [
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
                              //validator: valScore,
                              autocorrect: false,
                              keyboardType: TextInputType.phone,
                              maxLength: 2,
                              controller: _englishController,
                              onChanged: (String value) {
                                setEnglish();
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
                              //validator: valScore,
                              autocorrect: false,
                              keyboardType: TextInputType.phone,
                              controller: _mathController,
                              maxLength: 2,
                              onChanged: (String value) {
                                setMath();
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: new TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Reading",
                            hintText: '/36',
                            counterText: '',
                          ),
                          //validator: valScore,
                          autocorrect: false,
                          maxLength: 2,
                          keyboardType: TextInputType.phone,
                          controller: _readingController,
                          onChanged: (String value) {
                            setReading();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _actTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ACT Subjects',
                      hintText: 'Enter your ACT subject result',
                    ),
                    onChanged: (String value) {
                      setActSubject();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                margin:
                    EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 5),
                child: TextFormField(
                  //validator: validateDate,
                  readOnly: true,
                  textAlign: TextAlign.center,
                  controller: _compositeController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyColors.primary(), fontWeight: FontWeight.bold),
                    alignLabelWithHint: true,
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColors.primary())),
                    focusColor: MyColors.primary(),
                    enabled: false,
                    border: OutlineInputBorder(),
                    labelText: 'Composite',
                    suffixIcon: Icon(
                      Icons.done,
                      color: MyColors.primary(),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                margin:
                    EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 20),
                child: TextFormField(
                  //validator: validateDate,
                  readOnly: true,
                  textAlign: TextAlign.center,
                  controller: _resultController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: MyColors.primary(), fontWeight: FontWeight.bold),
                    alignLabelWithHint: true,
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyColors.primary())),
                    enabled: false,
                    border: OutlineInputBorder(),
                    labelText: 'SAT I',
                    hintText: 'Final SAT I Result',
                    suffixIcon: Icon(
                      Icons.done,
                      color: MyColors.primary(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 10, bottom: 15, left: 20, right: 20),
            child: TextFormField(
              //validator: validateDate,
              readOnly: true,
              textAlign: TextAlign.center,
              controller: _resultSubjectsController,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelStyle:
                TextStyle(
                    color: MyColors.primary(), fontWeight: FontWeight.bold),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.primary())),
                focusColor: MyColors.primary(),
                enabled: false,
                border: OutlineInputBorder(),
                labelText: 'SAT II',
                hintText: 'Act to SAT II',
                suffixIcon: Icon(
                  Icons.done,
                  color: MyColors.primary(),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            color: MyColors.primary(),
            child: FlatButton(
              child: Text(
                "CALCULATE",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                setState(() {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    curve: Curves.bounceOut,
                    duration: const Duration(milliseconds: 500),
                  );
                  setResult();
                  setCompositeScore();
                  setResultScore();
                });
              },
            ),
          ),
        ],
      )),
    );
  }

  void setEnglish() {
    calculators.english = double.parse(_englishController.text);
  }

  void setMath() {
    calculators.math = double.parse(_mathController.text);
  }

  void setReading() {
    calculators.reading = double.parse(_readingController.text);
  }

  void setResult() {
    _resultController.text = calculators.convertActToSat1().toString();
  }

  void setCompositeScore() {
    _compositeController.text = calculators.compositeScore.toString();
  }

  void setActSubject() {
    calculators.actSubjects = int.parse(_actTextController.text);
  }

  void setResultScore() {
    _resultSubjectsController.text =
        calculators.convertActSubjectsToSat2().toString();
  }

  double getWidthSize(double factor) {
    return MediaQuery.of(context).size.width * factor;
  }

  double getHeightSize(double factor) {
    return MediaQuery.of(context).size.height * factor;
  }
}
