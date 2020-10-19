import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:score_log_app/screen/sat1/addSat1.dart';

class ScoreSat1 extends StatefulWidget {
  const ScoreSat1({Key key}) : super(key: key);

  @override
  _ScoreSat1State createState() => _ScoreSat1State();
}

class _ScoreSat1State extends State<ScoreSat1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 48,
              bottom: TabBar(
                labelPadding: EdgeInsets.only(bottom: 13.5, top: 13.5),
                tabs: [
                  Text(
                    'Practice',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Real',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                ListView(
                  children: [
                    SAT1ListItem(
                      englishScore: 460,
                      mathScore: 690,
                      dateDay: 18,
                      dateMonth: 12,
                      dateYear: 2020,
                      onPressedDelete: () {},
                      note: 'This is a mini note...hello there',
                    ),
                    SAT1ListItem(
                      englishScore: 460,
                      mathScore: 690,
                      dateDay: 18,
                      dateMonth: 12,
                      dateYear: 2020,
                      onPressedDelete: () {},
                      note: 'This is a mini note...hello there',
                    ),
                  ],
                ),
                Icon(Icons.directions_transit),
              ],
            ),
            floatingActionButton: OpenContainer(
                closedBuilder: (_, openContainer){
                  return FloatingActionButton(
                    elevation: 0.0,
                    onPressed: openContainer,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.add, color: Colors.white, size: 35,),
                  );
                },
                openColor: Colors.blue,
                closedElevation: 5.0,
                closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)
                ),
                closedColor: Colors.blue,
                openBuilder: (_, closeContainer){
                  return AddSAT1();
                }
            ),),
      ),
    );
  }
}

class SAT1ListItem extends StatefulWidget {
  final int englishScore;
  final int mathScore;
  final int dateYear;
  final int dateDay;
  final int dateMonth;
  final String note;
  final VoidCallback onPressedDelete;

  SAT1ListItem({
    Key key,
    @required this.englishScore,
    @required this.mathScore,
    @required this.dateDay,
    @required this.dateMonth,
    @required this.dateYear,
    this.onPressedDelete,
    this.note,
  });

  @override
  _SAT1ListItemState createState() => _SAT1ListItemState();
}

class _SAT1ListItemState extends State<SAT1ListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 7,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
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
                        style: TextStyle(color: Colors.blue, fontSize: getWidthSize(.059)),
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
                  margin: EdgeInsets.only(left: getWidthSize(0.04), right: getWidthSize(0.04)),
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
                        scoreText('Total', widget.englishScore + widget.mathScore),
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
  double getWidthSize(double factor){
    return  MediaQuery.of(context).size.width * factor;
  }
  double getHeightSize(double factor){
    return  MediaQuery.of(context).size.height * factor;
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
                color: Colors.black, fontSize: getWidthSize(.06), fontWeight: FontWeight.bold),
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
