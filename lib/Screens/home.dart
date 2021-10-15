import 'package:apple/Samples/BarSample.dart';
import 'package:apple/Samples/SalesData.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apple/Screens/profile.dart';
import 'package:apple/Screens/settings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:apple/Templates/gradient.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: Main(),
      theme: CupertinoThemeData(),
      debugShowCheckedModeBanner: false,
    );
  }
}

List<Widget> tabOptions = [
  Localizations(
      locale: const Locale('en', 'US'),
      delegates: <LocalizationsDelegate<dynamic>>[
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
      ],
      child: Home()),
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
    checkUserAccelerometer();
  }

  checkUserAccelerometer() {
    double kilometersPerHour = 0.0;
    bool isPassenger = false;
    const double averageRunningSpeed = 9.4;

    Geolocator.getPositionStream(
            intervalDuration: const Duration(seconds: 1),
            desiredAccuracy: LocationAccuracy.high)
        .listen((position) {
      kilometersPerHour = position.speed * 3.6;
      print(kilometersPerHour); // Remove later
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
                  IconGradient(
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
                SizedBox(height: 50.0),
                Center(
                  child: Card(
                    child: Column(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Overview",
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
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Production",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "85.2K",
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "\u{2191} 20.7%",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.green),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Tender",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "85.2K",
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "\u{2193} 10.2%",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 15.0,
                        color: CupertinoColors.systemGrey,
                      ),
                      Container(
                        height: 400,
                        child: Center(
                            child: SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          title: ChartTitle(text: 'Inflation - Consumer price'),
                          legend: Legend(
                              isVisible: true,
                              overflowMode: LegendItemOverflowMode.wrap),
                          primaryXAxis: DateTimeAxis(
                              intervalType: DateTimeIntervalType.days,
                              interval: 7,
                              majorGridLines: const MajorGridLines(width: 0)),
                          primaryYAxis: NumericAxis(
                              labelFormat: '{value}',
                              axisLine: const AxisLine(width: 0),
                              majorTickLines: const MajorTickLines(
                                  color: Colors.transparent)),
                          series: getDefaultLineSeries(),
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                          ),
                        )),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
