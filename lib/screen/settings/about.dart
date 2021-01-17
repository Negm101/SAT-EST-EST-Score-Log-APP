import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:score_log_app/services/generalVar.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  String calculationFormulaSpan =
      """<div class="block block-bg p-4 mb-4 rounded-lg border">
                            <strong>Government universities if the score is above 1090:</strong>
                            <p class="thin">
                                (SAT 1 score/1600) *69 + (SAT 2 score/1600) *15 + GPA.</p>
                        
                            <strong>Private universities if the score is above 1090:</strong>
                            <p class="thin">
                                (SAT 1 score/1600) *75 + (SAT 2 score/1600) *15 + GPA.</p>
                        
                            <strong>If score is below 1090:</strong>
                            <p class="mb-0 thin">
                                (SAT 1 score/1600) *60 + (SAT 2 score/1600) *15 + GPA.</p>
                        </div>""";
  String egyptianUniRules = """
  <div class="block bg-white p-4 mb-md-0 mb-4 rounded-lg border">
                        <strong>For government universities:</strong>
                        <p class="thin">
                        - You must get at least 1050 score in SAT 1.<br>
                        - To add the SAT 2 score, you must get at least 1100 score.<br>
                        - The bonus for getting a score above 1090 is 9%.</p>
                    
                        <strong>For private universities:</strong>
                        <p class="thin">
                        - To add the SAT 2 score, you must get at least 900 score<br>
                        - The bonus for getting above 1090 is 15%.</p>
                    
                        <strong>For higher institutes:</strong>
                        <p class="mb-0 thin">
                        - You must get at least 890 score in SAT 1.<br>
                        - To add the SAT 2 score, you must get at least 900 score.</p>
                    </div>
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About Calculators'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Builder(
          builder: (context) {
            return ListView(
              children: [
                _expansionTile('Egyptian Uni Rules',
                    textSpan: _HtmlToSpan(context, egyptianUniRules)),
                _expansionTile('Calculation Formula',
                    textSpan: _HtmlToSpan(context, calculationFormulaSpan)),
                _actConversionTable(),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: MyColors.white(),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: ExpansionTile(
                    //initiallyExpanded: true,
                    title: Text('Credits'),
                    expandedAlignment: Alignment.centerLeft,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: RichText(
                          text: TextSpan(
                            text:
                                'Some of the materials used in this program was inspired from',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' click here\n',
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => _launchURL()),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }

  _launchURL() async {
    const url =
        'https://sat-score-calculator-for-egyptian-universities.netlify.app/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

/*'Some of the materials used in this program was inspired from \n https://sat-score-calculator-for-egyptian-universities.netlify.app/'*/
  Widget _expansionTile(String title, {InlineSpan textSpan}) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: MyColors.white(),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 4.0,
          ),
        ],
      ),
      child: ExpansionTile(
        //initiallyExpanded: true,
        title: Text(title),
        expandedAlignment: Alignment.centerLeft,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: RichText(
              text: textSpan,
            ),
          )
        ],
      ),
    );
  }

  TextSpan _HtmlToSpan(BuildContext context, String text) {
    return HTML.toTextSpan(
      context,
      text,
      // as name suggests, optionally set the default text style
      defaultTextStyle: TextStyle(color: Colors.grey[700]),
      overrideStyle: {
        "p": TextStyle(
          fontSize: 17.3,
        ),
        "strong": TextStyle(fontSize: 16),
        "a": TextStyle(wordSpacing: 2),
        // specify any tag not just the supported ones,
        // and apply TextStyles to them and/override them
      },
    );
  }

  Widget _actConversionTable() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: MyColors.white(),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: ExpansionTile(
              //initiallyExpanded: true,
              title: Text('ACT Conversion Table'),
              children: <Widget>[
                _getDataTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getDataTable() {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'ACT 1',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'SAT 1',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'ACT 2',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'SAT 2',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('9')),
            DataCell(Text('610')),
            DataCell(Text('10')),
            DataCell(Text('260')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('10')),
            DataCell(Text('640')),
            DataCell(Text('11')),
            DataCell(Text('280')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('11')),
            DataCell(Text('680')),
            DataCell(Text('12')),
            DataCell(Text('310')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12')),
            DataCell(Text('720')),
            DataCell(Text('13')),
            DataCell(Text('330')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('13')),
            DataCell(Text('770')),
            DataCell(Text('14')),
            DataCell(Text('360')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('14')),
            DataCell(Text('820')),
            DataCell(Text('15')),
            DataCell(Text('400')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('15')),
            DataCell(Text('870')),
            DataCell(Text('16')),
            DataCell(Text('430')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('16')),
            DataCell(Text('910')),
            DataCell(Text('17')),
            DataCell(Text('470')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('17')),
            DataCell(Text('950')),
            DataCell(Text('18')),
            DataCell(Text('500')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('18')),
            DataCell(Text('980')),
            DataCell(Text('19')),
            DataCell(Text('510')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('19')),
            DataCell(Text('1020')),
            DataCell(Text('20')),
            DataCell(Text('520')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('20')),
            DataCell(Text('1050')),
            DataCell(Text('21')),
            DataCell(Text('530')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('21')),
            DataCell(Text('1090')),
            DataCell(Text('22')),
            DataCell(Text('540')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('22')),
            DataCell(Text('1120')),
            DataCell(Text('23')),
            DataCell(Text('560')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('23')),
            DataCell(Text('1150')),
            DataCell(Text('24')),
            DataCell(Text('580')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('24')),
            DataCell(Text('1190')),
            DataCell(Text('25')),
            DataCell(Text('590')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('25')),
            DataCell(Text('1220')),
            DataCell(Text('26')),
            DataCell(Text('610')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('26')),
            DataCell(Text('1240')),
            DataCell(Text('27')),
            DataCell(Text('640')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('27')),
            DataCell(Text('1290')),
            DataCell(Text('28')),
            DataCell(Text('660')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('28')),
            DataCell(Text('1320')),
            DataCell(Text('29')),
            DataCell(Text('680')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('29')),
            DataCell(Text('1350')),
            DataCell(Text('30')),
            DataCell(Text('700')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('30')),
            DataCell(Text('1380')),
            DataCell(Text('31')),
            DataCell(Text('710')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('31')),
            DataCell(Text('1410')),
            DataCell(Text('32')),
            DataCell(Text('720')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('32')),
            DataCell(Text('1440')),
            DataCell(Text('33')),
            DataCell(Text('740')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('33')),
            DataCell(Text('1480')),
            DataCell(Text('34')),
            DataCell(Text('760')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('34')),
            DataCell(Text('1520')),
            DataCell(Text('35')),
            DataCell(Text('780')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('35')),
            DataCell(Text('1560')),
            DataCell(Text('36')),
            DataCell(Text('800')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('35')),
            DataCell(Text('1600')),
            DataCell(Text('')),
            DataCell(Text('')),
          ],
        ),
      ],
    );
  }
}
