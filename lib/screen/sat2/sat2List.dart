import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:score_log_app/model/sat2/scoreIIPractice.dart';
import 'package:score_log_app/model/sat2/scoreIIReal.dart';
import 'package:score_log_app/screen/sat2/addSat2Practice.dart';
import 'package:score_log_app/screen/sat2/sat2ListItemPractice.dart';
import 'package:score_log_app/screen/sat2/sat2ListItemReal.dart';

import 'addSat2Real.dart';

// ignore: must_be_immutable
class ScoreSat2 extends StatefulWidget {
  @override
  ScoreSat2State createState() => ScoreSat2State();
}

class ScoreSat2State extends State<ScoreSat2> {
  ScoreIIPractice scorePractice = new ScoreIIPractice.db();
  ScoreIIReal scoreReal = new ScoreIIReal.db();
  DataSatIIReal real = new DataSatIIReal();
  DataSatIIPractice practice = new DataSatIIPractice();
  int pageOpen = 0;

  @override
  Widget build(BuildContext context) {
    practice.autoRefresh(setState);
    real.autoRefresh(setState);

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            automaticallyImplyLeading: false,
            title: Text('SAT II'),
            actions: [
              PopupMenuButton(
                onSelected: (button){
                  if(button == 0){
                    sortByScore();
                  }
                  else if(button == 1){
                    sortBySubject();
                  }
                  else if(button == 2){
                    sortByDate();
                  }
                },
                padding: EdgeInsets.all(0),
                tooltip: 'Sort',
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                        child: Text('Sort by score'),
                      value: 0,
                    ),
                    PopupMenuItem(
                        child: Text('Sort by subject'),
                      value: 1,
                    ),
                    PopupMenuItem(
                        child: Text('Sort by date'),
                      value: 2,
                    ),
                  ];
                },
              )
            ],
            bottom: TabBar(
              labelPadding: EdgeInsets.only(bottom: 13.5, top: 13.5),
              onTap: (index) {
                if (index == 0) {
                  setState(() {
                    pageOpen = 0;
                    debugPrint('Current Page = $pageOpen');
                  });
                } else if (index == 1) {
                  setState(() {
                    pageOpen = 1;
                    debugPrint('Current Page = $pageOpen');
                  });
                }
              },
              tabs: [
                Text(
                  'Real',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Practice',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              getScoreIIReal(),
              getScoreIIPractice(),
            ],
          ),
          floatingActionButton: OpenContainer(
              closedBuilder: (_, openContainer) {
                return FloatingActionButton(
                  elevation: 0.0,
                  onPressed: openContainer,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 35,
                  ),
                );
              },
              openColor: Colors.blue,
              closedElevation: 5.0,
              closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              closedColor: Colors.blue,
              openBuilder: (_, closeContainer) {
                if (pageOpen == 0) {
                  real.updateListView(setState);
                  return AddSAT2Real(ScoreIIReal(0, '', '', ''));
                } else if (pageOpen == 1) {
                  practice.updateListView(setState);
                  return AddSAT2Practice(ScoreIIPractice(0, '', '', ''));
                } else {
                  return Center(
                    child: Text('error at openBuilder'),
                  );
                }
              }),
        ),
      ),
    );
  }

  Widget getScoreIIReal() {
    if (real.scoreList.length == 0) {
      return Center(
        child: Text(
          '(اه سمؤة) \nNO SCORES AVAILABLE',
          style: TextStyle(),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return real.scoreList.length != 0
          ? RefreshIndicator(
              child: ListView.builder(
                itemCount: real.scoreList.length,
                itemBuilder: (BuildContext context, position) {
                  position = position;
                  debugPrint(real.scoreList[position].id.toString() +
                      ' | ' +
                      real.scoreList[position].score.toString() +
                      ' | ' +
                      real.scoreList[position].subject.toString());
                  return SAT2ListItemReal(
                    score: real.scoreList[position].score,
                    subject: real.scoreList[position].subject,
                    dateDay: real.getDateDay(real.scoreList[position].date),
                    dateMonth: real.getDateMonth(real.scoreList[position].date),
                    dateYear: real.getDateYear(real.scoreList[position].date),
                    onPressedDelete: () {
                      setState(() {
                        real.delete(
                            context, real.scoreList[position], setState);
                        real.scoreList.removeAt(position);
                      });
                    },
                    note: real.scoreList[position].note,
                  );
                },
              ),
              onRefresh: getDataReal,
              displacement: 20,
            )
          : Center(child: CircularProgressIndicator());
    }
  }

  Widget getScoreIIPractice() {
    if (practice.scoreList.length == 0) {
      return Center(
        child: Text(
          '(اه سمؤة) \nNO SCORES AVAILABLE',
          style: TextStyle(),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return practice.scoreList.length != 0
          ? RefreshIndicator(
              child: ListView.builder(
                itemCount: practice.scoreList.length,
                itemBuilder: (BuildContext context, position) {
                  position = position;
                  debugPrint(position.toString() +
                      ' | ' +
                      practice.scoreList[position].id.toString() +
                      ' | ' +
                      practice.scoreList[position].score.toString() +
                      ' | ' +
                      practice.scoreList[position].subject.toString() +
                      ' | ' +
                      practice.scoreList[position].date.toString() +
                      ' | ' +
                      practice.scoreList[position].note.toString());
                  return SAT2ListItemPractice(
                    score: practice.scoreList[position].score,
                    subject: practice.scoreList[position].subject,
                    dateDay:
                        practice.getDateDay(practice.scoreList[position].date),
                    dateMonth: practice
                        .getDateMonth(practice.scoreList[position].date),
                    dateYear:
                        practice.getDateYear(practice.scoreList[position].date),
                    onPressedDelete: () {
                      setState(() {
                        practice.delete(
                            context, practice.scoreList[position], setState);
                        practice.scoreList.removeAt(position);
                      });
                    },
                    note: practice.scoreList[position].note,
                  );
                },
              ),
              onRefresh: getDataPractice,
              displacement: 20,
            )
          : Center(child: CircularProgressIndicator());
    }
  }

  Future<void> getDataReal() async {
    real.updateListView(setState);
  }

  Future<void> getDataPractice() async {
    practice.updateListView(setState);
  }

  Future<void> sortBySubject() async {
    if(pageOpen == 0){
      real.updateListViewSortBy(setState, scoreReal.dbSubject);
    }
    else if(pageOpen == 1){
      practice.updateListViewSortBy(setState, scorePractice.dbSubject);
    }
  }

  Future<void> sortByScore() async {
    if(pageOpen == 0){
      real.updateListViewSortBy(setState, scoreReal.dbScore);
    }
    else if(pageOpen == 1){
      practice.updateListViewSortBy(setState, scorePractice.dbScore);
    }
  }


  Future<void> sortByDate() async {
    if(pageOpen == 0){
      real.updateListViewSortBy(setState, scoreReal.dbDate);
    }
    else if(pageOpen == 1){
      practice.updateListViewSortBy(setState, scorePractice.dbDate);
    }
  }


}
