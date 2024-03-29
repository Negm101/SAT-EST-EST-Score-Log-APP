
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:intl/intl.dart';
import 'package:score_log_app/model/sat1/scoreIReal.dart';
import 'package:score_log_app/services/database.dart';
import 'package:score_log_app/services/generalVar.dart';

class AddSAT1Real extends StatefulWidget {
  final ScoreIReal scoreI;

  AddSAT1Real(this.scoreI);

  @override
  State<StatefulWidget> createState() {
    return _AddSAT1RealState(this.scoreI);
  }
}

class _AddSAT1RealState extends State<AddSAT1Real> {
  _AddSAT1RealState(this.scoreI);

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController _englishScoreController = new TextEditingController();
  TextEditingController _mathScoreController = new TextEditingController();
  TextEditingController _noteController = new TextEditingController();
  TextEditingController _scoreDateController = new TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());
  String scoreType = 'Practice';
  int _state = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();
  ScoreIReal scoreI;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: Text(
            'Add Score (real)',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          actions: <Widget>[
            new Container(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 5.0, 10.0),
            )
          ]),
      body: body(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: MyColors.primary(),
          child: FlatButton(
            child: Text(
              'ADD',
              style: TextStyle(
                  color: MyColors.white(), fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              setState(() {
                _save();
              });
            },
          ),
        ),
      ),
    );
  }

  Widget body() {
    return new Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: getWidthSize(0.05), right: getWidthSize(0.05)),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: new TextFormField(
                          decoration: const InputDecoration(
                            labelText: "English",
                            hintText: "/800",
                            counterText: '',
                          ),
                          validator: validateScore,
                          autocorrect: false,
                          keyboardType: TextInputType.phone,
                          maxLength: 4,
                          controller: _englishScoreController,
                          onChanged: (String value) {
                            setEnglishScore();
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: new TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Math",
                            hintText: '/800',
                            counterText: '',
                            errorMaxLines: 4,
                            //errorText: validateScore(value),
                          ),
                          validator: validateScore,
                          autocorrect: false,
                          keyboardType: TextInputType.phone,
                          maxLength: 4,
                          controller: _mathScoreController,
                          onChanged: (String value) {
                            setMathScore();
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: new TextField(
                      decoration: const InputDecoration(
                          labelText: "Note",
                          hintText: 'type a simple note',
                          errorMaxLines: 1),
                      autocorrect: false,
                      maxLength: 32,
                      controller: _noteController,
                      onChanged: (String value) {
                        setNote();
                      },
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      validator: validateDate,
                      readOnly: true,
                      controller: _scoreDateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Date of taking the test',
                        suffixIcon: Icon(Icons.date_range),
                      ),
                      onTap: () {
                        showPickerDate(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  double getWidthSize(double factor) {
    return MediaQuery.of(context).size.width * factor;
  }

  double getHeightSize(double factor) {
    return MediaQuery.of(context).size.height * factor;
  }
  void setEnglishScore(){
    scoreI.englishScore = int.parse(_englishScoreController.text);
  }
  void setMathScore(){
    scoreI.mathScore = int.parse(_mathScoreController.text);
  }
  void setDate(){
    scoreI.date = _scoreDateController.text;
  }
  void setTestType(){
    scoreI.type = scoreType;
  }
  void setNote(){
    scoreI.note = _noteController.text;
  }
  void _save() async {
      if(_formKey.currentState.validate()){
        setDate();
        await databaseHelper.insertScoreSatIReal(scoreI);
        Navigator.pop(context);
      }
      else {
        debugPrint('error');
      }
  }
  String validateScore(String value) {
    if (value.length == 0){
      return "Field can\'t be empty";
    }
    else if (int.parse(value.toString()) > 800) {
      return "At most 800";
    }
    else if (int.parse(value.toString()) < 200) {
      return "At least 200";
    }
    else {
      return null;
    }
  }
  String validateDate(String date){
    if(date.length == 0){
      return "Field can\'t be empty";
    }
    return null;
  }

  String validateNote(String note) {
    if (note.length > 32) {
      return "At most 32 characters";
    }
    else {
      return null;
    }
  }

  showPickerDate(BuildContext context) {
    Picker(
        hideHeader: false,
        adapter: DateTimePickerAdapter(
          minValue: DateTime(2000, 1, 1),
          maxValue: DateTime.now(),
        ),
        headercolor: MyColors.primary(),
        cancelTextStyle:
            TextStyle(color: MyColors.white(), fontWeight: FontWeight.bold),
        confirmTextStyle:
            TextStyle(color: MyColors.white(), fontWeight: FontWeight.bold),
        selectedTextStyle: TextStyle(color: MyColors.primary()),
        onConfirm: (Picker picker, List value) {
          var date = (picker.adapter as DateTimePickerAdapter).value;
          _scoreDateController.text = getDateFormat(date);
          setDate();
        }).showModal(context);
  }

  String getDateFormat(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
