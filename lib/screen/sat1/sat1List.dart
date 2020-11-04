import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:score_log_app/model/sat1/scoreIPractice.dart';
import 'package:score_log_app/model/sat1/scoreIReal.dart';
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
  ScoreIReal scoreReal = new ScoreIReal.db();
  ScoreIPractice scorePractice = new ScoreIPractice.db();
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
            leading: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('SAT I'),
            actions: [
              PopupMenuButton(

                onSelected: (button) {
                  if (button == 0) {
                    sortByScore();
                  } else if (button == 1) {
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
                      child: Text('Sort by date'),
                      value: 1,
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
              getScoreIReal(),
              getScoreIPractice(),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.white,
                  onPressed: () {
                    showDialogDelete(context);
                  },
                ),
              ],
            ),
            color: Colors.blue,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
                  return AddSAT1Real(ScoreIReal(
                      0, 0, '', 'Practice', '(no note was specified)'));
                } else if (pageOpen == 1) {
                  practice.updateListView(setState);
                  return AddSAT1Practice(ScoreIPractice(
                      0, 0, '', 0, 0, '(no note was specified)'));
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
          'NO SCORES AVAILABLE',
          style: TextStyle(),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return real.scoreList.length != 0
          ? RefreshIndicator(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: real.scoreList.length,
                itemBuilder: (BuildContext context, position) {
                  position = position;
                  debugPrint(real.scoreList[position].id.toString() +
                      ' | ' +
                      real.scoreList[position].englishScore.toString() +
                      ' | ' +
                      real.scoreList[position].mathScore.toString());
                  return SAT1ListItemReal(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
          'NO SCORES AVAILABLE',
          style: TextStyle(),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return practice.scoreList.length != 0
          ? RefreshIndicator(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: practice.scoreList.length,
                itemBuilder: (BuildContext context, position) {
                  position = position;
                  debugPrint(position.toString() +
                      ' | ' +
                      practice.scoreList[position].id.toString() +
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
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                    readingScore: practice.scoreList[position].readingScore,
                    writingScore: practice.scoreList[position].writingScore,
                    mathCalcScore: practice.scoreList[position].mathCalcScore,
                    mathNoCalScore:
                        practice.scoreList[position].mathNoCalcScore,
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

  Future<void> sortByScore() async {
    if (pageOpen == 0) {
      real.updateListViewSortBy(setState,
          '${scoreReal.dbEnglishScore} ASC,${scoreReal.dbMathScore} ASC');
    } else if (pageOpen == 1) {
      practice.updateListViewSortBy(setState,
              '${scorePractice.dbReadingScore} ASC,'
              '${scorePractice.dbWritingScore} ASC, '
              '${scorePractice.dbMathWithNoCalcScore} ASC, '
              '${scorePractice.dbMathCalcScore} ASC ');
    }
  }

  Future<void> sortByDate() async {
    if (pageOpen == 0) {
      real.updateListViewSortBy(setState, scoreReal.dbDate);
    } else if (pageOpen == 1) {
      practice.updateListViewSortBy(setState, scorePractice.dbDate);
    }
  }

  EdgeInsets getMargin(int length, int id){
    if (id == length){
      return EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 80);
    }
    else{
      return EdgeInsets.only(left: 10, right: 10, top: 20);
    }
  }
  showDialogDelete(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel", style: TextStyle(color: Colors.grey),),
      onPressed:  () { Navigator.pop(context);},
    );
    Widget continueButton = FlatButton(
      child: Text("Delete", style: TextStyle(color: Colors.red),),
      onPressed:  () {
        if(pageOpen == 0){
          real.deleteAll(setState);
        }
        else if(pageOpen == 1){
          practice.deleteAll(setState);
        }
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete all SAT I scores"),
      //content: Text("Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
