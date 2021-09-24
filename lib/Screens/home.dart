import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:apple/Screens/profile.dart';
import 'package:apple/Screens/settings.dart';
import 'package:apple/Samples/Time-Series.dart';
import 'package:apple/Samples/Ordinal-Timeline.dart';
import 'package:apple/Samples/LinearSales-List.dart';
import 'package:apple/Templates/gradientIcon.dart';

class HomePage extends StatelessWidget {
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
  void initState() {
    super.initState();
    checkGeolocator();
  }

  checkGeolocator() async {
    double kilometersPerHour = 0.0;
    bool isPassenger = false;
    const double averageRunningSpeed = 9.4;

    Geolocator.getPositionStream(
        intervalDuration: const Duration(seconds: 1),
        desiredAccuracy: LocationAccuracy.high)
        .listen((position) {
      kilometersPerHour = position.speed * 3.6;
      print(kilometersPerHour);

      if (kilometersPerHour > averageRunningSpeed) {
        if (!isPassenger) {
          showAlert(context);
          isPassenger = true;
        }
      }
    });
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text("You're going too fast!"),
          content: Column(
            children: const <Widget>[
              SizedBox(
                height: 10.0,
              ),
              GradientIcon(
                CupertinoIcons.speedometer,
                125.0,
                LinearGradient(
                  colors: <Color>[
                    CupertinoColors.systemYellow,
                    CupertinoColors.systemOrange,
                    CupertinoColors.systemRed,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                  'This app should not be used while operating machinery.'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                Navigator.pop(context, "I'M A PASSENGER"),
              },
              child: const Text("I'M A PASSENGER"),
            ),
          ],
        ));
  }

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
                SizedBox(height: 20.0),
                Center(
                  child: Card(
                    child: Column(
                      children: <Widget> [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Overview",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 15.0,
                          color: CupertinoColors.systemGrey,
                        ),
                        Container(
                          height: 400,
                          child: charts.TimeSeriesChart(
                            timeSeries,
                            dateTimeFactory: const charts.LocalDateTimeFactory(),
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
                      ]
                    ),
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

