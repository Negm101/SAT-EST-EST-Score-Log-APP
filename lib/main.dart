import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:score_log_app/screen/calculator.dart';
import 'package:score_log_app/screen/scores.dart';
import 'package:score_log_app/screen/tansik.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  static const String _title = 'EgyScore';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Home(),
      theme: ThemeData(
          textTheme: GoogleFonts.oxygenTextTheme(
        Theme.of(context).textTheme,
      )),
    );

  }
}

/// This is the stateful widget that the main application instantiates.
class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _HomeState extends State<Home> {
  int _selectedIndex = 1;
  static  List<Widget> _widgetOptions = <Widget>[
    Scores(),
    Calculator(),
    Tansik(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'Egy Score';
    return Scaffold(
      appBar: AppBar(
          title: const Center(
            child: Text(title, textAlign: TextAlign.center,),)
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Scores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculators',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Tansik',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        unselectedItemColor: Colors.grey[300],
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,

      ),
    );
  }
}
