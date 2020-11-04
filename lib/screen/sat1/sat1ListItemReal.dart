import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:score_log_app/model/sat1/scoreIReal.dart';
import 'package:score_log_app/services/database.dart';
import 'package:score_log_app/services/generalVar.dart';
import 'package:sqflite/sqflite.dart';

class SAT1ListItemReal extends StatefulWidget {
  final int englishScore;
  final int mathScore;
  final int dateYear;
  final int dateDay;
  final int dateMonth;
  final String note;
  final EdgeInsets margin;
  final VoidCallback onPressedDelete;


  SAT1ListItemReal({
    Key key,
    @required this.englishScore,
    @required this.mathScore,
    @required this.dateDay,
    @required this.dateMonth,
    @required this.dateYear,
    @required this.margin,
    this.onPressedDelete,
    this.note,
  });

  @override
  _SAT1ListItemRealState createState() => _SAT1ListItemRealState();
}

class _SAT1ListItemRealState extends State<SAT1ListItemReal> {
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
                      margin: EdgeInsets.fromLTRB(14, 0, 0, 0),
                      child: Text(
                        widget.dateYear.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(14, 1, 0, 2),
                      child: Text(
                        widget.dateDay.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.primary(),
                            fontSize: getWidthSize(.059)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(14, 0, 0, 0),
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
                        scoreText('English', widget.englishScore),
                        scoreText('Math', widget.mathScore),
                        scoreText(
                            'Total', widget.englishScore + widget.mathScore),
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
              margin: EdgeInsets.only(right: getWidthSize(0.015)),
              alignment: Alignment.center,
              child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: getWidthSize(.07),
                    semanticLabel: 'delete',
                  ),
                  onPressed: widget.onPressedDelete),
            ),
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
          margin: EdgeInsets.fromLTRB(0, 1, getWidthSize(.05), 2),
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
class DataSatIReal{
  DatabaseHelper databaseHelper = DatabaseHelper();
  ScoreIReal title = new ScoreIReal.db();
  List<ScoreIReal> scoreList;
  int count = 0;

  //ScoreSat1State sat1state = ScoreSat1State();
  void autoRefresh(Function setState){
    if (scoreList == null) {
      scoreList = List<ScoreIReal>();
      updateListView(setState);
    }

  }
  // when calling this function wrap it in a setState
  Future<void> getDataReal(Function setState) async {
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
      Future<List<ScoreIReal>> noteListFuture = databaseHelper.getScoreIListReal();
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
      Future<List<ScoreIReal>> noteListFuture = databaseHelper.getScoreIListRealSortBy(sortBy);
      noteListFuture.then((scoreIList) {
        setState(() {
          this.scoreList = scoreIList;
          this.count = scoreIList.length;
        });
      });
    });
  }

  void delete(BuildContext context, ScoreIReal score, Function setState) async {
    int result = await databaseHelper.deleteScoreSatIReal(score.id);
    if (result != 0) {
      debugPrint('Score Deleted Successfully');
      updateListView(setState);
    }
  }

  void deleteAll(Function setState) async{
    int result = await databaseHelper.deleteAllFrom(title.dbTableName);
    if (result != 0) {
      debugPrint('Score Deleted Successfully');
      updateListView(setState);
    }
  }
}