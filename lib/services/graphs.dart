import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:score_log_app/model/sat1/scoreIPractice.dart';
import 'package:score_log_app/model/sat1/scoreIReal.dart';

import 'generalVar.dart';

class Sat1RealGraph extends StatefulWidget {
  final List<ScoreIReal> scoreList;
  final int itemCount;
  final GlobalKey key;

  Sat1RealGraph({
    @required this.key,
    @required this.scoreList,
    @required this.itemCount,
  });

  @override
  _Sat1RealGraphState createState() => _Sat1RealGraphState();
}

class _Sat1RealGraphState extends State<Sat1RealGraph> {
  final Color _color = MyColors.yellow();
  final int minScoreForChart = 2;
  bool _isTotalSelected = true;
  bool _isEnglishSelected = false;
  bool _isMathSelected = false;
  int _selection = 0;
  double _totalDivideBy = 1600;
  static const double _pressElevation = 0;

  @override
  Widget build(BuildContext context) {
    final double _deviceHeight = MediaQuery.of(context).size.height;
    final double _deviceWidth = MediaQuery.of(context).size.width;
    const Offset _offset = Offset(0.0, 1.0);
    if (widget.scoreList.length < minScoreForChart) {
      return Container(
        alignment: Alignment.center,
        height: _deviceHeight / 6,
        width: _deviceWidth,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: _offset, //(x,y)
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Text(
          'No Enough Scores\n( At-least 3 scores ) ',
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
        decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(5),
          color: MyColors.primary(),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: _offset, //(x,y)
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: _deviceWidth,
              height: _deviceHeight / 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: ChoiceChip(
                      label: const Text('Total'),
                      selected: _isTotalSelected,
                      pressElevation: _pressElevation,
                      selectedColor: MyColors.yellow().withOpacity(.8),
                      backgroundColor: Colors.grey[200],
                      onSelected: (value) {
                        setState(() {
                          _selection = 0;
                          _setAllChoiceToFalse();
                          _isTotalSelected = true;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: ChoiceChip(
                      label: const Text('English'),
                      pressElevation: _pressElevation,
                      selected: _isEnglishSelected,
                      selectedColor: MyColors.yellow().withOpacity(.8),
                      backgroundColor: Colors.grey[200],
                      onSelected: (value) {
                        setState(() {
                          _selection = 1;
                          _setAllChoiceToFalse();
                          _isEnglishSelected = true;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: ChoiceChip(
                      label: const Text('Math'),
                      selected: _isMathSelected,
                      pressElevation: _pressElevation,
                      selectedColor: MyColors.yellow().withOpacity(.8),
                      backgroundColor: Colors.grey[200],
                      onSelected: (value) {
                        setState(() {
                          _selection = 2;
                          _setAllChoiceToFalse();
                          _isMathSelected = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            //Divider(color: MyColors.primary(),),
            Container(
                height: _deviceHeight / 3.75,
                width: _deviceWidth,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ListView.builder(
                        itemCount: widget.scoreList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, position) {
                          position = position;
                          double _getScore() {
                            if (_selection == 0) {
                              _setTotalDivideBy(1600);
                              return (widget.scoreList[position].englishScore +
                                      widget.scoreList[position].mathScore)
                                  .toDouble();
                            }
                            if (_selection == 1) {
                              _setTotalDivideBy(800);
                              return widget.scoreList[position].englishScore
                                  .toDouble();
                            }
                            if (_selection == 2) {
                              _setTotalDivideBy(800);
                              return widget.scoreList[position].mathScore
                                  .toDouble();
                            } else {
                              debugPrint('error at selection');
                              return -1;
                            }
                          }

                          return _bar(
                              _getDateDay(widget.scoreList[position].date),
                              _getDateMonth(widget.scoreList[position].date),
                              _getScore(),
                              widget.scoreList[position].date);
                        }),
                  ],
                )),
          ],
        ),
      );
    }
  }

  void _setAllChoiceToFalse() {
    _isMathSelected = false;
    _isEnglishSelected = false;
    _isTotalSelected = false;
  }

  String _getDateDay(String date) {
    return DateTime.parse(date).day.toString();
  }

  String _getDateMonth(String date) {
    return DateTime.parse(date).month.toString();
  }

  void _setTotalDivideBy(double value) {
    _totalDivideBy = value;
  }

  Widget _bar(String day, String month, double score, String fullDate) {
    return Container(child: LayoutBuilder(
      builder: (context, constrains) {
        final double _height = constrains.maxHeight;
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Tooltip(
              isTapOn: true,
              verticalOffset: -(_height / 1.3) * (score / _totalDivideBy),
              message:
                  '$score : ${DateFormat.yMMMMd('en_US').format(DateTime.parse(fullDate))}',
              decoration: BoxDecoration(
                color: MyColors.green().withOpacity(.8),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.grey[200],
                    ),
                    height: (_height / 1.3),
                    width: _height / 7,
                    margin: EdgeInsets.only(
                        left: 10, right: 10, bottom: _height / 30),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: _color,
                    ),
                    height: (_height / 1.3) * (score / _totalDivideBy),
                    width: _height / 7,
                    margin: EdgeInsets.only(
                        left: 10, right: 10, bottom: _height / 30),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: _height / 30),
              height: 1,
            ),
            Text(
              '$day/$month',
              style: TextStyle(
                  color: MyColors.white(), fontWeight: FontWeight.bold),
            )
          ],
        );
      },
    ));
  }
}

class Sat1PracticeGraph extends StatefulWidget {
  final List<ScoreIPractice> scoreList;
  final int itemCount;
  final GlobalKey key;

  Sat1PracticeGraph({
    @required this.key,
    @required this.scoreList,
    @required this.itemCount,
  });

  @override
  _Sat1PracticeGraphState createState() => _Sat1PracticeGraphState();
}

class _Sat1PracticeGraphState extends State<Sat1PracticeGraph> {
  final Color _color = MyColors.yellow();
  final int minScoreForChart = 2;

  //bool _isAverageSelected = true;
  bool _isReadingSelected = true;
  bool _isWritingSelected = false;
  bool _isMathSelected = false;
  bool _isMathCalcSelected = false;
  int _selection = 1;
  double _totalDivideBy = 154;
  static const double _pressElevation = 0;

  @override
  Widget build(BuildContext context) {
    final double _deviceHeight = MediaQuery.of(context).size.height;
    final double _deviceWidth = MediaQuery.of(context).size.width;
    const Offset _offset = Offset(0.0, 1.0);

    if (widget.scoreList.length < minScoreForChart) {
      return Container(
        alignment: Alignment.center,
        height: _deviceHeight / 6,
        width: _deviceWidth,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: _offset, //(x,y)
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Text(
          'No Enough Scores\n( At-least 3 scores ) ',
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
        decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(5),
          color: MyColors.primary(),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: _offset, //(x,y)
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: _deviceWidth,
              height: _deviceHeight / 10,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: ChoiceChip(
                      label: const Text('Reading'),
                      pressElevation: _pressElevation,
                      selected: _isReadingSelected,
                      selectedColor: MyColors.yellow().withOpacity(.8),
                      backgroundColor: Colors.grey[200],
                      onSelected: (value) {
                        setState(() {
                          _selection = 1;
                          _setAllChoiceToFalse();
                          _isReadingSelected = true;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: ChoiceChip(
                      label: const Text('Writing'),
                      selected: _isWritingSelected,
                      selectedColor: MyColors.yellow().withOpacity(.8),
                      backgroundColor: Colors.grey[200],
                      pressElevation: _pressElevation,
                      onSelected: (value) {
                        setState(() {
                          _selection = 2;
                          _setAllChoiceToFalse();
                          _isWritingSelected = true;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: ChoiceChip(
                      label: const Text('Math'),
                      selected: _isMathSelected,
                      selectedColor: MyColors.yellow().withOpacity(.8),
                      backgroundColor: Colors.grey[200],
                      pressElevation: _pressElevation,
                      onSelected: (value) {
                        setState(() {
                          _selection = 3;
                          _setAllChoiceToFalse();
                          _isMathSelected = true;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: ChoiceChip(
                      label: const Text('Math Calculator'),
                      selected: _isMathCalcSelected,
                      selectedColor: MyColors.yellow().withOpacity(.8),
                      backgroundColor: Colors.grey[200],
                      pressElevation: _pressElevation,
                      onSelected: (value) {
                        setState(() {
                          _selection = 4;
                          _setAllChoiceToFalse();
                          _isMathCalcSelected = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            //Divider(color: MyColors.primary(),),
            Container(
                height: _deviceHeight / 3.75,
                width: _deviceWidth,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ListView.builder(
                        itemCount: widget.scoreList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, position) {
                          position = position;
                          int _getTotal() {
                            return (widget.scoreList[position].readingScore +
                                widget.scoreList[position].writingScore +
                                widget.scoreList[position].mathCalcScore +
                                widget.scoreList[position].mathNoCalcScore);
                          }

                          double _getScore() {
                            if (_selection == 0) {
                              _setTotalDivideBy(154);
                              return _getTotal().toDouble();
                            }
                            if (_selection == 1) {
                              _setTotalDivideBy(52);
                              return widget.scoreList[position].readingScore
                                  .toDouble();
                            }
                            if (_selection == 2) {
                              _setTotalDivideBy(44);
                              return widget.scoreList[position].writingScore
                                  .toDouble();
                            }
                            if (_selection == 3) {
                              _setTotalDivideBy(20);
                              return widget.scoreList[position].mathNoCalcScore
                                  .toDouble();
                            }
                            if (_selection == 4) {
                              _setTotalDivideBy(38);
                              return widget.scoreList[position].mathCalcScore
                                  .toDouble();
                            } else {
                              debugPrint('error at selection');
                              return -1;
                            }
                          }

                          return _bar(
                              _getDateDay(widget.scoreList[position].date),
                              _getDateMonth(widget.scoreList[position].date),
                              _getScore(),
                              widget.scoreList[position].date);
                        }),
                    /*Container(
                      margin: EdgeInsets.only(
                          top: 5,
                          bottom: _deviceHeight / 28),
                      height: 1,
                      width: _deviceWidth,
                      color: Colors.grey,
                    ),*/
                  ],
                )),
          ],
        ),
      );
    }
  }

  void _setAllChoiceToFalse() {
    _isWritingSelected = false;
    _isReadingSelected = false;
    // _isAverageSelected = false;
    _isMathSelected = false;
    _isMathCalcSelected = false;
  }

  String _getDateDay(String date) {
    return DateTime.parse(date).day.toString();
  }

  String _getDateMonth(String date) {
    return DateTime.parse(date).month.toString();
  }

  void _setTotalDivideBy(double value) {
    _totalDivideBy = value;
  }

  Widget _bar(String day, String month, double score, String fullDate) {
    return Container(child: LayoutBuilder(
      builder: (context, constrains) {
        final double _height = constrains.maxHeight;
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Tooltip(
                isTapOn: true,
                verticalOffset: -(_height / 1.3) * (score / _totalDivideBy),
                message:
                    '$score : ${DateFormat.yMMMMd('en_US').format(DateTime.parse(fullDate))}',
                decoration: BoxDecoration(
                  color: MyColors.green().withOpacity(.8),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey[200],
                      ),
                      height: (_height / 1.3),
                      width: _height / 7,
                      margin: EdgeInsets.only(
                          left: 10, right: 10, bottom: _height / 30),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: _color.withOpacity(.8),
                      ),
                      height: (_height / 1.3) * (score / _totalDivideBy),
                      width: _height / 7,
                      margin: EdgeInsets.only(
                          left: 10, right: 10, bottom: _height / 30),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(bottom: _height / 30),
              height: 1,
            ),
            Text(
              '$day/$month',
              style: TextStyle(
                  color: MyColors.white(), fontWeight: FontWeight.bold),
            )
          ],
        );
      },
    ));
  }
}
