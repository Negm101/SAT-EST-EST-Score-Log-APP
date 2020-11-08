import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_log_app/services/calculators.dart';
import 'package:score_log_app/services/generalVar.dart';

class SatCalc extends StatefulWidget {
  final Calculators calculators;

  SatCalc(this.calculators);

  @override
  State<StatefulWidget> createState() {
    return _SatCalcState(this.calculators);
  }
}

class _SatCalcState extends State<SatCalc> {
  _SatCalcState(this.calculators);

  Calculators calculators;
  TextEditingController _sat1Controller = new TextEditingController();
  TextEditingController _sat2Controller = new TextEditingController();
  TextEditingController _gpaController = new TextEditingController();
  TextEditingController _resultController =
      new TextEditingController(text: ' ');
  final _scrollController = ScrollController();
  final pageController = PageController(viewportFraction: 0.8);
  bool isPublicSelected = true;
  bool isPrivateSelected = false;
  bool _isPublic = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: Text(
            'Tansik Percent',
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
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: new TextFormField(
                    decoration: const InputDecoration(
                      //border: OutlineInputBorder(),
                      labelText: "SAT I",
                      hintText: "/1600",
                      counterText: '',
                    ),
                    //validator: validateScore,
                    autocorrect: false,
                    keyboardType: TextInputType.phone,
                    maxLength: 4,
                    controller: _sat1Controller,
                    onChanged: (String value) {
                      setSat1();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: new TextFormField(
                    decoration: const InputDecoration(
                      //border: OutlineInputBorder(),
                      labelText: "SAT II",
                      hintText: "/1600",
                      counterText: '',
                    ),
                    //validator: validateScore,
                    autocorrect: false,
                    keyboardType: TextInputType.phone,
                    maxLength: 4,
                    controller: _sat2Controller,
                    onChanged: (String value) {
                      setSat2();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 30),
                  child: new TextFormField(
                    decoration: const InputDecoration(
                      //border: OutlineInputBorder(),
                      labelText: "GPA",
                      hintText: "/40",
                      counterText: '',
                    ),
                    //validator: validateScore,
                    autocorrect: false,
                    keyboardType: TextInputType.phone,
                    maxLength: 4,
                    controller: _gpaController,
                    onChanged: (String value) {
                      setGpa();
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChoiceChip(
                      label: Text('Public'),
                      padding: EdgeInsets.only(
                          left: getWidthSize(.135),
                          right: getWidthSize(.135),
                          top: 10,
                          bottom: 10),
                      selected: isPublicSelected,
                      onSelected: (bool value) {
                        setState(() {
                          isPrivateSelected = false;
                          isPublicSelected = true;
                          _isPublic = true;
                        });
                        setIsPublic();
                      },
                    ),
                    ChoiceChip(
                      label: Text('Private'),
                      padding: EdgeInsets.only(
                          left: getWidthSize(.135),
                          right: getWidthSize(.135),
                          top: 10,
                          bottom: 10),
                      selected: isPrivateSelected,
                      onSelected: (bool value) {
                        setState(() {
                          isPublicSelected = false;
                          isPrivateSelected = true;
                          _isPublic = false;
                        });
                        setIsPublic();
                      },
                    ),
                  ],
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
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
            child: TextFormField(
              //validator: validateDate,
              readOnly: true,
              controller: _resultController,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                    color: MyColors.primary(), fontWeight: FontWeight.bold),
                alignLabelWithHint: true,
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyColors.primary())),
                focusColor: MyColors.primary(),
                enabled: false,
                border: OutlineInputBorder(),
                labelText: 'Final Result',
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
                });
              },
            ),
          ),
        ],
      )),
    );
  }

  void setSat1() {
    calculators.sat1 = double.parse(_sat1Controller.text);
  }

  void setSat2() {
    calculators.sat2 = double.parse(_sat2Controller.text);
  }

  void setGpa() {
    calculators.gpa = double.parse(_gpaController.text);
  }

  void setIsPublic() {
    calculators.isPublic = _isPublic;
  }

  void setResult() {
    _resultController.text = calculators.getTansikScore();
  }

  double getWidthSize(double factor) {
    return MediaQuery.of(context).size.width * factor;
  }

  double getHeightSize(double factor) {
    return MediaQuery.of(context).size.height * factor;
  }
}
