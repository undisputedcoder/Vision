import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apple/Screens/profile.dart';
import 'package:apple/Screens/settings.dart';
import 'package:apple/Samples/Time-Series.dart';
import 'package:apple/Samples/Ordinal-Timeline.dart';
import 'package:apple/Samples/LinearSales-List.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: Main(),
      theme: CupertinoThemeData(),
    );
  }
}

List<Widget> tabOptions = [
  Home(),
  Profile(),
  Settings(),
];

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings), label: 'Settings')
          ],
        ),
        tabBuilder: (BuildContext context, index) {
          return tabOptions[index];
        });
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        navigationBar: CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.all(2.0),
          middle: Text("Analytics"),
        ),
        child: SafeArea(
          child: CupertinoScrollbar(
            thickness: 4,
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: <Widget>[
                Card(
                  child: Container(
                    child: ListTile(
                      leading: CupertinoButton(
                        child: Icon(CupertinoIcons.calendar),
                        onPressed: () {},
                      ),
                      title: Text("13 Sep - 11 Oct"),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Card(
                  child: Container(
                    height: 400,
                    child: Center(
                        child: charts.TimeSeriesChart(
                      timeSeries,
                      dateTimeFactory: const charts.LocalDateTimeFactory(),
                    )),
                  ),
                ),
                SizedBox(height: 50.0),
                Card(
                  child: Container(
                    height: 400,
                    child: Center(
                      child: charts.BarChart(
                        series,
                        animate: true,
                        barGroupingType: charts.BarGroupingType.grouped,
                        behaviors: [
                          new charts.SeriesLegend(
                              position: charts.BehaviorPosition.bottom),
                          new charts.ChartTitle(
                            "Top title",
                            subTitle: "Top sub-title",
                            behaviorPosition: charts.BehaviorPosition.top,
                            titleOutsideJustification:
                                charts.OutsideJustification.middle,
                            innerPadding: 18,
                          ),
                          new charts.ChartTitle('Bottom title',
                              behaviorPosition: charts.BehaviorPosition.bottom,
                              titleOutsideJustification:
                                  charts.OutsideJustification.middleDrawArea),
                          new charts.ChartTitle('Start title',
                              behaviorPosition: charts.BehaviorPosition.start,
                              titleOutsideJustification:
                                  charts.OutsideJustification.middleDrawArea)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                Card(
                  child: Container(
                    height: 400,
                    child: Center(
                      child: charts.ScatterPlotChart(
                        sales,
                        animate: true,
                        behaviors: [
                          new charts.ChartTitle(
                            "Top title",
                            subTitle: "Top sub-title",
                            behaviorPosition: charts.BehaviorPosition.top,
                            titleOutsideJustification:
                                charts.OutsideJustification.middle,
                            innerPadding: 18,
                          ),
                          new charts.ChartTitle('Bottom title',
                              behaviorPosition: charts.BehaviorPosition.bottom,
                              titleOutsideJustification:
                                  charts.OutsideJustification.middleDrawArea),
                          new charts.ChartTitle('Start title',
                              behaviorPosition: charts.BehaviorPosition.start,
                              titleOutsideJustification:
                                  charts.OutsideJustification.middleDrawArea)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

