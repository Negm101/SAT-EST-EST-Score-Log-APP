import 'package:flutter/material.dart';
import 'package:score_log_app/model/tansik.dart';
import 'package:score_log_app/services/databaseTansik.dart';
import 'package:sqflite/sqflite.dart';

class Tansik extends StatefulWidget {
  @override
  _TansikState createState() => _TansikState();
}

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

  @override
  Widget build(BuildContext context) {
    dataTansik.autoRefresh(setState, '2020');
    return Column(
      children: [
        Container(
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
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dataTansik.tansikList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dataTansik.tansikList[index].university),
                trailing: Text(dataTansik.tansikList[index].percent.toString()),
              );
            },
          ),
        ),
      ],
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
