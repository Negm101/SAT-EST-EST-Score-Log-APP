import 'package:flutter/material.dart';
import 'package:score_log_app/screen/calculators/actCalc.dart';
import 'package:score_log_app/screen/calculators/satCalc.dart';
import 'package:score_log_app/services/calculators.dart';
import 'package:score_log_app/services/generalVar.dart';

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomButton(
            title: 'Tansik Percent',
            state: '',
            elevation: 0,
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new SatCalc(Calculators.sat(0, 0, 0))));
            },
          ),
          CustomButton(
            title: 'ACT to SAT Score',
            state: '(beta)',
            elevation: 0,
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      new ActCalc(Calculators.act(0, 0, 0))));
            },
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String title;
  final String state;
  final VoidCallback onPressed;
  final double elevation;

  CustomButton({
    Key key,
    @required this.title,
    @required this.state,
    this.elevation = 4,
    this.onPressed,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  MyColors colors = new MyColors.primary();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          color: Colors.white,
          elevation: widget.elevation,
          onPressed: widget.onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  circle(),
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Text(
                  widget.state,
                  style: TextStyle(fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget circle() {
    return Container(
        width: 16,
        height: 16,
        decoration: new BoxDecoration(
          color: MyColors.primary(),
          shape: BoxShape.circle,
        ));
  }
}
