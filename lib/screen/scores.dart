import 'package:flutter/material.dart';
import 'package:score_log_app/screen/sat1/sat1List.dart';
import 'package:score_log_app/screen/sat2/sat2List.dart';
import 'package:score_log_app/services/database.dart';
import 'package:score_log_app/services/generalVar.dart';

import 'act/actList.dart';

class Scores extends StatefulWidget {
  @override
  _ScoresState createState() => _ScoresState();
}

class _ScoresState extends State<Scores> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  int sat1Count = 0;
  int sat2Count = 0;
  int actCount = 0;

  @override
  Widget build(BuildContext context) {
    getSat1Count();
    getSat2Count();
    getActCount();
    return Container(
      child: ListView(
        children: [
          CustomButton(
            title: 'SAT I',
            elevation: 0,
            numberOfScores: sat1Count,
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new ScoreSat1()));
            },
          ),
          CustomButton(
            title: 'SAT II',
            elevation: 0,
            numberOfScores: sat2Count,
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new ScoreSat2())
              );
            },
          ),
          CustomButton(
            title: 'ACT',
            elevation: 0,
            numberOfScores: actCount,
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new ActScore())
              );
            },
          )
        ],
      ),
    );
  }

  void getSat1Count() async {
    int countR = await databaseHelper.getCountSatIReal();
    int countP = await databaseHelper.getCountSatIPractice();
    debugPrint((countR + countP).toString());
    if (sat1Count == (countP + countR)) {
      sat1Count = countP + countR;
    }
    else {
      setState(() {
        sat1Count = countR + countP;
      });
    }
  }

  void getSat2Count() async {
    int countR = await databaseHelper.getCountSatIIPractice();
    int countP = await databaseHelper.getCountSatIIReal();
    debugPrint((countR + countP).toString());
    if (sat2Count == (countP + countR)) {
      sat2Count = countP + countR;
    }
    else {
      setState(() {
        sat2Count = countR + countP;
      });
    }
  }

  void getActCount() async {
    int countR = await databaseHelper.getCountActReal();
    int countP = await databaseHelper.getCountActPractice();
    debugPrint((countR + countP).toString());
    if (actCount == (countP + countR)) {
      actCount = countP + countR;
    }
    else {
      setState(() {
        actCount = countR + countP;
      });
    }
  }
}

class CustomButton extends StatefulWidget {
  final String title;
  final int numberOfScores;
  final VoidCallback onPressed;
  final double elevation;

  CustomButton({
    Key key,
    @required this.title,
    @required this.numberOfScores,
    this.elevation = 4,
    this.onPressed,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  MyColors colors = new MyColors.primary();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          color: Colors.white,
          elevation: widget.elevation,
          onPressed: widget.onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  circle(),
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Text(
                      widget.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  '${widget.numberOfScores.toString()} score(s)',
                  style: TextStyle(fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget circle() {
    return Container(
        width: 16,
        height: 16,
        decoration: new BoxDecoration(
          color: MyColors.primary(),
          shape: BoxShape.circle,
        ));
  }
}
