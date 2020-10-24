import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:score_log_app/model/scoreIPractice.dart';
import 'package:score_log_app/model/scoreIReal.dart';
import 'package:score_log_app/screen/sat1/addSat1Practice.dart';
import 'package:score_log_app/screen/sat1/addSat1Real.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:score_log_app/screen/sat1/sat1ListItemReal.dart';
import 'package:score_log_app/services/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:date_format/date_format.dart';

// ignore: must_be_immutable
class ScoreSat1 extends StatefulWidget {
  int position;

  @override
  ScoreSat1State createState() => ScoreSat1State();
}

class ScoreSat1State extends State<ScoreSat1> {
  DataSatIReal real = new DataSatIReal();
  @override
  Widget build(BuildContext context) {
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
                    real.currentPage = 0;
                    debugPrint('Current Page = ${real.currentPage}');
                  });
                } else if (index == 1) {
                  setState(() {
                    real.currentPage = 1;
                    debugPrint('Current Page = ${real.currentPage}');
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
              getScoreIItem(),
              Center(),
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
                if (real.currentPage == 0) {
                  real.updateListView(setState);
                  return AddSAT1Real(ScoreIReal(0, 0, '', 'Practice', ''));
                } else if (real.currentPage == 1) {
                  real.updateListView(setState);
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

  Widget getScoreIItem() {
    //getDataReal();
    if (real.scoreList.length == 0){
      return Center(
        child: Text('(اه سمؤة) \nNO SCORES AVAILABLE', style: TextStyle(),textAlign: TextAlign.center,),
      );
    }
    else {
      return real.scoreList.length != 0
          ? RefreshIndicator(
        child: ListView.builder(
          itemCount: real.scoreList.length,
          itemBuilder: (BuildContext context, position) {
            position = position;
            debugPrint(real.scoreList[position].id.toString() + ' | '  + real.scoreList[position].englishScore.toString() + ' | ' + real.scoreList[position].mathScore.toString());
            return SAT1ListItemReal(
              englishScore: real.scoreList[position].englishScore,
              mathScore: real.scoreList[position].mathScore,
              dateDay: real.getDateDay(real.scoreList[position].date),
              dateMonth: real.getDateMonth(real.scoreList[position].date),
              dateYear: real.getDateYear(real.scoreList[position].date),
              onPressedDelete: () {
                setState(() {
                  real.delete(context, real.scoreList[position],setState);
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
          :Center(child: CircularProgressIndicator());
    }
  }

  Future<void> getDataReal() async {
    real.updateListView(setState);
}
}
