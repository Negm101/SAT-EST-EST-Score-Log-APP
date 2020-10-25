import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:score_log_app/model/scoreIPractice.dart';
import 'package:score_log_app/model/scoreIReal.dart';
import 'package:score_log_app/screen/sat1/addSat1Practice.dart';
import 'package:score_log_app/screen/sat1/addSat1Real.dart';
import 'package:score_log_app/screen/sat1/sat1ListItemPractice.dart';
import 'package:score_log_app/screen/sat1/sat1ListItemReal.dart';

// ignore: must_be_immutable
class ScoreSat1 extends StatefulWidget {
  @override
  ScoreSat1State createState() => ScoreSat1State();
}

class ScoreSat1State extends State<ScoreSat1> {
  DataSatIReal real = new DataSatIReal();
  DataSatIPractice practice = new DataSatIPractice();
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
            automaticallyImplyLeading: false,
            toolbarHeight: 48,
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
              getScoreIReal(),
              getScoreIPractice(),
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
                  return AddSAT1Real(ScoreIReal(0, 0, '', 'Practice', ''));
                } else if (pageOpen == 1) {
                  practice.updateListView(setState);
                  return AddSAT1Practice(ScoreIPractice(0, 0, '', 0, 0, ''));
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

  Widget getScoreIReal() {
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
                      real.scoreList[position].englishScore.toString() +
                      ' | ' +
                      real.scoreList[position].mathScore.toString());
                  return SAT1ListItemReal(
                    englishScore: real.scoreList[position].englishScore,
                    mathScore: real.scoreList[position].mathScore,
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

  Widget getScoreIPractice() {
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
                  debugPrint(practice.scoreList[position].id.toString() +
                      ' | ' +
                      practice.scoreList[position].readingScore.toString() +
                      ' | ' +
                      practice.scoreList[position].writingScore.toString() +
                      ' | ' +
                      practice.scoreList[position].mathNoCalcScore.toString() +
                      ' | ' +
                      practice.scoreList[position].mathCalcScore.toString() +
                      ' | ' +
                      practice.scoreList[position].date.toString() +
                      ' | ' +
                      practice.scoreList[position].note.toString());
                  return SAT1ListItemPractice(
                    readingScore: practice.scoreList[position].readingScore,
                    writingScore: practice.scoreList[position].writingScore,
                    mathCalcScore: practice.scoreList[position].mathCalcScore,
                    mathNoCalScore: practice.scoreList[position].mathNoCalcScore,
                    dateDay: practice.getDateDay(practice.scoreList[position].date),
                    dateMonth: practice.getDateMonth(practice.scoreList[position].date),
                    dateYear: practice.getDateYear(practice.scoreList[position].date),
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
}
