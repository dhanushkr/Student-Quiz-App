import "package:flutter/material.dart";
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/rendering.dart';
import './home.dart';

/// Sample ordinal data type.
class Subject {
  final String lang;
  final int score;
  Subject(this.lang, this.score);
}

class About extends StatelessWidget {
  var data;
  About(this.data);

  /// Create one series with sample hard coded data.

  List<charts.Series<Subject, String>> _createSampleData() {
    print(data);
    List<Subject> data2 = [];
    for (var v in data) {
      data2.add(new Subject(v[0], int.parse(v[1])));
    }
    return [
      new charts.Series<Subject, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Subject sales, _) => sales.lang,
        measureFn: (Subject sales, _) => sales.score,
        data: data2,
        labelAccessorFn: (Subject row, _) => '${row.lang}: ${row.score}',
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SimpleBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }
}

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Student App"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => homepage()));
              },
            ),
          ],
        ),
        body:ListView(
          
          children: <Widget>[
          Card(
            elevation: 10,
            child: Container(
              height: 750,
              width: double.infinity,
              child: new charts.BarChart(
                seriesList,
                animate: animate,
              ),
            ),
          ),
          Card(
            elevation: 10,
            child: Container(
              height: 750,
              width: double.infinity,
              child: new charts.PieChart(
                seriesList,
                animate: animate,
                defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 100,
            arcRendererDecorators: [new charts.ArcLabelDecorator()])
              ),
            ),
          ),
        ]));
  }
}
