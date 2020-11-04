import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_log_app/services/calculators.dart';

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
                        debugPrint('is public:  ' + _isPublic.toString());
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
                        debugPrint('is public:  ' + _isPublic.toString());
                      },
                    ),
                  ],
                ),
                /*
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 5),

                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/3,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),

                  child: PageView(

                    controller:pageController,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 5, right:30, left: 0),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('For government universities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: getHeightSize(.03)),textAlign: TextAlign.center,),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Text('- You must get at least 1050 score in SAT 1.', style: TextStyle(fontSize: getHeightSize(.020)),),
                            ),
                            Text('- To add the SAT 2 score, you must get at least   1100 score.', style: TextStyle(fontSize: getHeightSize(.020)),),
                            Text('- The bonus for getting a score above 1090 is 9%.', style: TextStyle(fontSize: getHeightSize(.020)),),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5, right: 0, left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('For private universities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: getHeightSize(.03)),textAlign: TextAlign.center,),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Text('- To add the SAT 2 score, you must get at least 900 score', style: TextStyle(fontSize: getHeightSize(.020)),),
                            ),

                            Text('- The bonus for getting above 1090 is 15%.', style: TextStyle(fontSize: getHeightSize(.020)),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 2,
                    effect: WormEffect(
                      activeDotColor: Colors.blue,
                      dotHeight: 10,
                      dotWidth: 10
                    ),
                  ),
                ),*/
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
                labelStyle:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                alignLabelWithHint: true,
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
                focusColor: Colors.blue,
                enabled: false,
                border: OutlineInputBorder(),
                labelText: 'Final Result',
                suffixIcon: Icon(
                  Icons.done,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
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
