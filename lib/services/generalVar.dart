import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:score_log_app/model/sat1/scoreIReal.dart';

class MyColors extends Color {
  MyColors.primary() : super(_getColorFromHex('215A84'));

  MyColors.primaryDark() : super(_getColorFromHex('032B43'));

  MyColors.textColor() : super(_getColorFromHex('000000'));

  MyColors.textColorDark() : super(_getColorFromHex('FFFFFF'));

  MyColors.tipColor() : super(_getColorFromHex('FFBA08'));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class MyBarChart extends StatefulWidget {
  final List<ScoreIReal> scoreList;
  final int itemCount;

  MyBarChart({
    Key key,
    @required this.scoreList,
    @required this.itemCount,
  });

  @override
  _MyBarChartState createState() => _MyBarChartState();
}

class _MyBarChartState extends State<MyBarChart> {
  @override
  Widget build(BuildContext context) {
    if (widget.scoreList.length < 3) {
      return Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height / 3.5,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
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
        child: Text(
          'No Enough Scores\n( Atleast 3 scores ) ',
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Container(
          height: MediaQuery.of(context).size.height / 3.5,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
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
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.itemCount,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, position) {
                    position = position;
                    return bar(
                        getDateDay(widget.scoreList[position].date),
                        getDateMonth(widget.scoreList[position].date),
                        widget.scoreList[position].englishScore.toDouble() +
                            widget.scoreList[position].mathScore.toDouble(),
                        (widget.scoreList[position].englishScore +
                                widget.scoreList[position].mathScore)
                            .toString(),
                        widget.scoreList[position].date);
                  }),
              Container(
                margin: EdgeInsets.only(
                    top: 5, bottom: MediaQuery.of(context).size.height / 28),
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
              ),
            ],
          ));
    }
  }

  String getDateDay(String date) {
    return DateTime.parse(date).day.toString();
  }

  String getDateYear(String date) {
    return DateTime.parse(date).year.toString();
  }

  String getDateMonth(String date) {
    return DateTime.parse(date).month.toString();
  }

  Widget bar(
      String day, String month, double score, String message, String fulldate) {
    return Container(child: LayoutBuilder(
      builder: (context, constrains) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Tooltip(
              isTapOn: true,
              verticalOffset: -(constrains.maxHeight / 1.5) * (score / 1600),
              message:
                  '$message : ${DateFormat.yMMMMd('en_US').format(DateTime.parse(fulldate))}',
              decoration: BoxDecoration(
                color: MyColors.tipColor(),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: MyColors.primary(),
                ),
                height: (constrains.maxHeight / 1.3) * (score / 1600),
                width: constrains.maxHeight / 8,
                margin: EdgeInsets.only(
                    left: 8, right: 8, bottom: constrains.maxHeight / 30),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: 0, bottom: constrains.maxHeight / 30),
              height: 1,
            ),
            Text(
              '$day/$month',
            )
          ],
        );
      },
    ));
  }
}
