import 'dart:async';

import 'package:apple/Samples/BarSample.dart';
import 'package:apple/Samples/SalesData.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apple/Screens/profile.dart';
import 'package:apple/Screens/setting.dart';
import 'package:apple/Templates/gradient.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apple/globals.dart';

late User _currentUser;

class HomePage extends StatelessWidget {
  final User user;
  const HomePage({required this.user});

  @override
  Widget build(BuildContext context) {
    final text = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? 'DarkTheme'
        : 'LightTheme';

    return MaterialApp(
      home: Main(user: user),
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
  Profile(user: _currentUser),
  Setting(),
];

class Main extends StatefulWidget {
  final User user;
  const Main({required this.user});

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

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
  DateTime current = DateTime.now();
  double production = roundDouble(productionTotal(chartData), 2);
  double tender = roundDouble(tenderTotal(chartData), 2);
  late List<ChartSampleData> _chartData1;

  displayProductionTotal() {
    setState(() {
      production = productionTotal(chartData);
    });
  }

  displayTenderTotal() {
    setState(() {
      tender = tenderTotal(chartData);
    });
  }

  @override
  void initState() {
    _chartData1 = getDefaultBarSeries();
    super.initState();
    checkUserAccelerometer();
  }

  checkUserSafeModeSwitch(subscription) {
    if (userSafeModeSwitch == true) {
      if (subscription.isPaused) {
        subscription.resume();
      }
    }

    if (userSafeModeSwitch == false) {
      if (!subscription.isPaused) {
        subscription.pause();
      }
    }
  }

  checkUserAccelerometer() {
    var subscription;
    double kilometersPerHour = 0.0;
    bool isPassenger = false;
    const double averageRunningSpeed = 9.4;
    int count = 0;

    subscription = Geolocator.getPositionStream(
            intervalDuration: const Duration(seconds: 3),
            desiredAccuracy: LocationAccuracy.high)
        .listen((position) {
      const oneSecond = Duration(seconds: 1);
      Timer.periodic(oneSecond, (Timer t) => checkUserSafeModeSwitch(subscription));
      kilometersPerHour = position.speed * 3.6;
      print(kilometersPerHour); // Remove later

      if (kilometersPerHour > averageRunningSpeed) {
        if (count < 3) {
          ++count;
        }

        if (!isPassenger && count == 3) {
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

  void showProdInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text("Production"),
              content: Text("Production is blah blah blah"),
              actions: [
                CupertinoDialogAction(
                  child: Text("OK"),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  void showTenderInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text("Tender"),
              content: Text("Tender is blah blah blah"),
              actions: [
                CupertinoDialogAction(
                  child: Text("OK"),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  void showHelp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text("Info"),
              content: Text("Blah blah blah"),
              actions: [
                CupertinoDialogAction(
                  child: Text("OK"),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    String currentFormatted = DateFormat('EEEE, dd MMM').format(current);
    String currentFormattedShort = DateFormat('dd MMM').format(current);
    DateTime thirtyDays = current.add(Duration(days: 30));
    String thirtyDaysFormatted = DateFormat('EEEE, dd MMM').format(thirtyDays);
    String thirtyDaysFormattedShort = DateFormat('dd MMM').format(thirtyDays);

    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        navigationBar: CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.all(2.0),
          middle: Text(
            "Analytics",
            style: TextStyle(fontSize: 18),
          ),
        ),
        child: SafeArea(
          child: CupertinoScrollbar(
            thickness: 4,
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: <Widget>[
                Center(
                  child: Card(
                    child: Column(children: <Widget>[
                      ListTile(
                        leading: Text(
                          "Target Overview",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: CupertinoButton(
                          child: Icon(CupertinoIcons.question_circle),
                          onPressed: () {
                            showHelp(context);
                          },
                        ),
                      ),
                      Divider(
                        height: 1.0,
                        color: CupertinoColors.systemGrey,
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8)),
                                      Text(
                                        "Select the start and end date",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final picked = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2021),
                                              lastDate: DateTime(2022));

                                          if (picked != null) {
                                            setState(() {
                                              current = picked;
                                              currentFormatted =
                                                  DateFormat('EEEE, dd MMM')
                                                      .format(current);
                                            });
                                          }
                                        },
                                        child: ListTile(
                                          title: Text("Start Date"),
                                          subtitle: Text("$currentFormatted"),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2021),
                                              lastDate: DateTime(2022));
                                        },
                                        child: ListTile(
                                          title: Text("End Date"),
                                          subtitle:
                                              Text("$thirtyDaysFormatted"),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.calendar,
                            color: CupertinoColors.systemBlue,
                          ),
                          title: Text(
                              "$currentFormattedShort - $thirtyDaysFormattedShort"),
                        ),
                      ),
                      Divider(
                        height: 5.0,
                        color: CupertinoColors.systemGrey,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showProdInfo(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Total Production ",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Icon(CupertinoIcons.info_circle_fill,
                                            size: 15),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '\$$production',
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
                          InkWell(
                            onTap: () {
                              showTenderInfo(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Total Tender ",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Icon(
                                          CupertinoIcons.info_circle_fill,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "\$$tender",
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
                          title: ChartTitle(text: 'Production vs Tender'),
                          legend: Legend(
                              isVisible: true,
                              overflowMode: LegendItemOverflowMode.wrap,
                              position: LegendPosition.bottom),
                          primaryXAxis: DateTimeAxis(
                              intervalType: DateTimeIntervalType.days,
                              interval: 7,
                              majorGridLines: const MajorGridLines(width: 0)),
                          primaryYAxis: NumericAxis(
                              labelFormat: '\${value}',
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
                SizedBox(
                  height: 20,
                ),
                Card(
                    child: Column(
                  children: [
                    ListTile(
                      leading: Text(
                        "Overview",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: CupertinoButton(
                          onPressed: () {},
                          child: Icon(CupertinoIcons.calendar)),
                    ),
                    Divider(
                      height: 1.0,
                      color: CupertinoColors.systemGrey,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "0%",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
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
                        title: ChartTitle(text: 'Production vs Tender'),
                        legend: Legend(
                          isVisible: true,
                          position: LegendPosition.bottom,
                        ),
                        primaryXAxis: CategoryAxis(
                            majorGridLines: const MajorGridLines(width: 0)),
                        series: <ChartSeries>[
                          ColumnSeries<ChartSampleData, String>(
                              dataSource: _chartData1,
                              xValueMapper: (ChartSampleData view1, _) =>
                                  view1.x,
                              yValueMapper: (ChartSampleData view1, _) =>
                                  view1.y,
                              name: 'Production'),
                          ColumnSeries<ChartSampleData, String>(
                              dataSource: _chartData1,
                              xValueMapper: (ChartSampleData view1, _) =>
                                  view1.x,
                              yValueMapper: (ChartSampleData view1, _) =>
                                  view1.y3,
                              name: 'Tender'),
                          ColumnSeries<ChartSampleData, String>(
                              dataSource: _chartData1,
                              xValueMapper: (ChartSampleData view1, _) =>
                                  view1.x,
                              yValueMapper: (ChartSampleData view1, _) =>
                                  view1.y2,
                              name: 'Presplit'),
                        ],
                        tooltipBehavior: TooltipBehavior(
                          enable: true,
                        ),
                      )),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
