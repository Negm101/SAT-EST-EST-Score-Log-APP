import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:score_log_app/model/settingsModel.dart';
import 'package:score_log_app/screen/calculator.dart';
import 'package:score_log_app/screen/scores.dart';
import 'package:score_log_app/screen/settings.dart';
import 'package:score_log_app/screen/tansik.dart';
import 'package:score_log_app/services/generalVar.dart';
import 'package:score_log_app/services/globalVar.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  static const String _title = 'EgyScore';
  final MyColors colors = new MyColors.primary();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    updateSettings();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Home(),
      theme: ThemeData(
        textTheme: GoogleFonts.oxygenTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: MyColors.primary(),
      ),
    );

  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final MyColors colors = new MyColors.primary();
  int _selectedIndex = 1;
  GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');

  static List<Widget> _widgetOptions = <Widget>[
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
    final BottomNavigationBar navigationBar = globalKey.currentWidget;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        leading: Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 20),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18),
          ),
        ),
        leadingWidth: MediaQuery.of(context).size.width / 2,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings_rounded,
              color: MyColors.white(),
            ),
            onPressed: () {
              _selectedIndex = 1;
              navigationBar.onTap(1);
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new Setting(SettingsModel(1, 1, 1, 1, 0, 0))));
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: globalKey,
        backgroundColor: MyColors.primary(),
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
        selectedItemColor: MyColors.white(),
        onTap: _onItemTapped,
      ),
    );
  }
}