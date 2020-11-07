import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:score_log_app/model/tansik.dart';
import 'package:score_log_app/services/databaseTansik.dart';
import 'package:sqflite/sqflite.dart';

class Tansik extends StatefulWidget {
  @override
  _TansikState createState() => _TansikState();
}

/*

 */
class _TansikState extends State<Tansik> {
  DatabaseTansik databaseTansik = new DatabaseTansik();
  DataTansik dataTansik = new DataTansik();
  bool _is20Selected = true;
  bool _is19Selected = false;
  bool _is18Selected = false;
  bool _is17Selected = false;
  bool _is16Selected = false;
  bool _is15Selected = false;
  bool _is14Selected = false;
  bool _is13Selected = false;
  bool _isFabVisible = true;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    dataTansik.autoRefresh(setState, '2020');
    return Scaffold(
      body: Column(
        children: [
          yearChoice(),
          Divider(
            height: 0,
          ),
          NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: Expanded(child: tansikList()),
          ),
        ],
      ),
      /*floatingActionButton: _isFabVisible
          ? FloatingActionButton(
              onPressed: () {},
              backgroundColor: MyColors.primary(),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            )
          : null,*/
    );
  }

  void setLoadingState() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Widget tansikList() {
    if (_isLoading == true) {
      setLoadingState();
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: dataTansik.tansikList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(dataTansik.tansikList[index].university),
                trailing: Text(dataTansik.tansikList[index].percent.toString()),
              ),
              Divider(
                height: 1,
              )
            ],
          );
        },
      );
    }
  }

  Widget yearChoice() {
    return Container(
      padding: EdgeInsets.only(top: 1, bottom: 1),
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: ChoiceChip(
              label: Text('2020'),
              selected: _is20Selected,
              onSelected: (value) {
                setState(() {
                  setAllChoiceChipsFalse();
                  _is20Selected = true;
                  dataTansik.updateListView(setState, '2020');
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: ChoiceChip(
              label: Text('2019'),
              selected: _is19Selected,
              onSelected: (value) {
                setState(() {
                  setAllChoiceChipsFalse();
                  _is19Selected = true;
                  dataTansik.updateListView(setState, '2019');
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: ChoiceChip(
              label: Text('2018'),
              selected: _is18Selected,
              onSelected: (value) {
                setState(() {
                  setAllChoiceChipsFalse();
                  _is18Selected = true;
                  dataTansik.updateListView(setState, '2018');
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: ChoiceChip(
              label: Text('2017'),
              selected: _is17Selected,
              onSelected: (value) {
                setState(() {
                  setAllChoiceChipsFalse();
                  _is17Selected = true;
                  dataTansik.updateListView(setState, '2017');
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: ChoiceChip(
              label: Text('2016'),
              selected: _is16Selected,
              onSelected: (value) {
                setState(() {
                  setAllChoiceChipsFalse();
                  _is16Selected = true;
                  dataTansik.updateListView(setState, '2016');
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: ChoiceChip(
              label: Text('2015'),
              selected: _is15Selected,
              onSelected: (value) {
                setState(() {
                  setAllChoiceChipsFalse();
                  _is15Selected = true;
                  dataTansik.updateListView(setState, '2015');
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: ChoiceChip(
              label: Text('2014'),
              selected: _is14Selected,
              onSelected: (value) {
                setState(() {
                  setAllChoiceChipsFalse();
                  _is14Selected = true;
                  dataTansik.updateListView(setState, '2014');
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: ChoiceChip(
              label: Text('2013'),
              selected: _is13Selected,
              onSelected: (value) {
                setState(() {
                  setAllChoiceChipsFalse();
                  _is13Selected = true;
                  dataTansik.updateListView(setState, '2013');
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void setAllChoiceChipsFalse() {
    _is20Selected = false;
    _is19Selected = false;
    _is18Selected = false;
    _is17Selected = false;
    _is16Selected = false;
    _is15Selected = false;
    _is14Selected = false;
    _is13Selected = false;
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              setState(() {
                _isFabVisible = true;
              });
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              setState(() {
                _isFabVisible = false;
              });
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }
}

class DataTansik {
  DatabaseTansik databaseHelper = DatabaseTansik();
  TansikModel title = TansikModel.db();
  List<TansikModel> tansikList;
  int count = 0;

  //ScoreSat1State sat1state = ScoreSat1State();
  void autoRefresh(Function setState, String year) {
    if (tansikList == null) {
      tansikList = List<TansikModel>();
      updateListView(setState, year);
    }
  }

  // when calling this function wrap it in a setState
  void updateListView(Function setState, String year) {
    final Future<Database> dbFuture = databaseHelper.initDB();
    dbFuture.then((database) {
      Future<List<TansikModel>> noteListFuture = databaseHelper.getTansik(year);
      noteListFuture.then((scoreIList) {
        setState(() {
          this.tansikList = scoreIList;
          this.count = scoreIList.length;
        });
      });
    });
  }
}
