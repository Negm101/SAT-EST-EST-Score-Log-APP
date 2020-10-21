import 'package:flutter/material.dart';
import 'package:score_log_app/screen/sat1/sat1List.dart';

class Scores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomButton(
            title: 'Button 1',
            elevation: 0,
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) => new ScoreSat1()));
            },
          ),
          CustomButton(
            title: 'Button 2',
            elevation: 0,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final double elevation;

  CustomButton({
    Key key,
    @required this.title,
    this.elevation = 4,
    this.onPressed,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        color: Colors.white,
        elevation: widget.elevation,
        onPressed: widget.onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            circle(),
            Text(
              widget.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            circle()
          ],
        ),
      ),
    );
  }

  Widget circle() {
    return Container(
        width: 18,
        height: 18,
        decoration: new BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ));
  }
}
