import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_log_app/model/sat2/scoreIIPractice.dart';
import 'package:score_log_app/services/database.dart';
import 'package:score_log_app/services/generalVar.dart';
import 'package:sqflite/sqflite.dart';

class SAT2ListItemPractice extends StatefulWidget {
  final int score;
  final int dateYear;
  final int dateDay;
  final int dateMonth;
  final String note;
  final String subject;
  final EdgeInsets margin;
  final VoidCallback onPressedDelete;


  SAT2ListItemPractice({
    Key key,
    @required this.score,
    @required this.subject,
    @required this.margin,
    this.dateDay,
    this.dateMonth,
    this.dateYear,
    this.onPressedDelete,
    this.note,
  });

  @override
  _SAT2ListItemPracticeState createState() => _SAT2ListItemPracticeState();
}

class _SAT2ListItemPracticeState extends State<SAT2ListItemPractice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 7,
      width: MediaQuery.of(context).size.width,
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(getWidthSize(0.04), 0, 0, 0),
                      child: Text(
                        widget.dateYear.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(getWidthSize(0.04), 1, 0, 2),
                      child: Text(
                        widget.dateDay.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primary(),
                            fontSize: getWidthSize(.059)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(getWidthSize(0.04), 0, 0, 0),
                      child: Text(
                        getMonth(widget.dateMonth),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: getWidthSize(0.04), right: getWidthSize(0.04)),
                  width: 1.5,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        scoreText(widget.subject, widget.score),
                        //scoreText('Total', widget.readingScore + widget.writingScore),
                      ],
                    ),
                    Container(
                      child: Text(
                        widget.note,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Container(
                //margin: EdgeInsets.only(right: getWidthSize(0.015)),
                alignment: Alignment.centerRight,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  height: MediaQuery.of(context).size.height,
                  minWidth: getWidthSize(0.15),
                  child: Icon(
                    Icons.delete,
                    size: getWidthSize(.065),
                    color: Colors.red,
                  ),
                  onPressed: widget.onPressedDelete,
                )),
          ],
        ),
      ),
    );
  }

  double getWidthSize(double factor) {
    return MediaQuery.of(context).size.width * factor;
  }

  double getHeightSize(double factor) {
    return MediaQuery.of(context).size.height * factor;
  }

  Widget scoreText(String label, int score) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 1, getWidthSize(.04), 2),
          child: Text(
            score.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: getWidthSize(.06),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  String getMonth(int monthNumber) {
    switch (monthNumber) {
      case 1:
        {
          return 'JAN';
        }
        break;

      case 2:
        {
          return 'FEB';
        }
        break;

      case 3:
        {
          return 'MAR';
        }
        break;

      case 4:
        {
          return 'APR';
        }
        break;

      case 5:
        {
          return 'MAY';
        }
        break;

      case 6:
        {
          return 'JUN';
        }
        break;

      case 7:
        {
          return 'JUL';
        }
        break;

      case 8:
        {
          return 'AUG';
        }
        break;

      case 9:
        {
          return 'SEP';
        }
        break;

      case 10:
        {
          return 'OCT';
        }
        break;

      case 11:
        {
          return 'NOV';
        }
        break;

      case 12:
        {
          return 'DEC';
        }
        break;

      default:
        {
          return 'NON';
        }
        break;
    }
  }
}
class DataSatIIPractice{
  DatabaseHelper databaseHelper = DatabaseHelper();
  ScoreIIPractice title = new ScoreIIPractice.db();
  List<ScoreIIPractice> scoreList;
  int count = 0;

  //ScoreSat1State sat1state = ScoreSat1State();
  void autoRefresh(Function setState){
    if (scoreList == null) {
      scoreList = List<ScoreIIPractice>();
      updateListView(setState);
    }

  }
  // when calling this function wrap it in a setState
  Future<void> getDataPractice(Function setState) async {
    updateListView(setState);
  }

  int getDateDay(String date) {
    return DateTime.parse(date).day.toInt();
  }


  int getDateYear(String date) {
    return DateTime.parse(date).year.toInt();
  }

  int getDateMonth(String date) {
    return DateTime.parse(date).month.toInt();
  }

  // when calling this function wrap it in a setState
  void updateListView(Function setState) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<ScoreIIPractice>> noteListFuture = databaseHelper.getScoreIIListPractice();
      noteListFuture.then((scoreIList) {
        setState(() {
          this.scoreList = scoreIList;
          this.count = scoreIList.length;
        });
      });
    });
  }

  void updateListViewSortBy(Function setState, String sortBy) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<ScoreIIPractice>> noteListFuture = databaseHelper.getScoreIIListPracticeSortBy(sortBy);
      noteListFuture.then((scoreIList) {
        setState(() {
          this.scoreList = scoreIList;
          this.count = scoreIList.length;
        });
      });
    });
  }


  void delete(BuildContext context, ScoreIIPractice score, Function setState) async {
    int result = await databaseHelper.deleteScoreSatIIPractice(score.id);
    if (result != 0) {
      updateListView(setState);
    }
  }
  void deleteAll(Function setState) async{
    int result = await databaseHelper.deleteAllFrom(title.dbTableName);
    if (result != 0) {
      updateListView(setState);
    }
  }
}