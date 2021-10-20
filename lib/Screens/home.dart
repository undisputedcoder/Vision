import 'package:apple/Samples/BarSample.dart';
import 'package:apple/Samples/SalesData.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apple/Screens/profile.dart';
import 'package:apple/Screens/settings.dart';
import 'package:apple/Templates/gradient.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Main(),
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
  Setting(),
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

  checkUserAccelerometer() {
    double kilometersPerHour = 0.0;
    bool isPassenger = false;
    const double averageRunningSpeed = 9.4;
    int count = 0;

    Geolocator.getPositionStream(
        intervalDuration: const Duration(seconds: 3),
        desiredAccuracy: LocationAccuracy.high)
        .listen((position) {
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        navigationBar: CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.all(2.0),
          middle: Text("Analytics",
            style: TextStyle(
              fontSize: 18
            ),
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
                    child: Column(
                        children: <Widget> [
                          ListTile(
                            leading: Text("Overview", style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: CupertinoButton(
                                onPressed: () {
                                  DateTime current = DateTime.now();
                                  String currentFormatted = DateFormat('EEEE, dd MMM').format(current);
                                  DateTime thirtyDays = current.add(Duration(days: 30));
                                  String thirtyDaysFormatted = DateFormat('EEEE, dd MMM').format(thirtyDays);

                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 200,
                                          child: Column(
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.only(top: 8)
                                              ),
                                              Text("Select the start and end date",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  final picked = await showDatePicker(
                                                      context: context,
                                                      initialDate: DateTime.now(),
                                                      firstDate: DateTime(2021),
                                                      lastDate: DateTime(2022)
                                                  );

                                                  if(picked != null) {
                                                    setState(() {
                                                      current = picked;
                                                      currentFormatted = DateFormat('EEEE, dd MMM').format(current);
                                                      print('$currentFormatted');
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
                                                      lastDate: DateTime(2022)
                                                  );
                                                },
                                                child: ListTile(
                                                  title: Text("End Date"),
                                                  subtitle: Text("$thirtyDaysFormatted"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                  );
                                },
                                child: Icon(CupertinoIcons.calendar)
                            ),
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
                                      child: Text("Production",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('$production',
                                        style: TextStyle(
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("\u{2191} 20.7%",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.green
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Tender",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("$tender",
                                        style: TextStyle(
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("\u{2193} 10.2%",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.red
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
                                      overflowMode: LegendItemOverflowMode.wrap),
                                  primaryXAxis: DateTimeAxis(
                                      intervalType: DateTimeIntervalType.days,
                                      interval: 7,
                                      majorGridLines: const MajorGridLines(width: 0)),
                                  primaryYAxis: NumericAxis(
                                      labelFormat: '{value}',
                                      axisLine: const AxisLine(width: 0),
                                      majorTickLines: const MajorTickLines(color: Colors.transparent)),
                                  series: getDefaultLineSeries(),
                                  tooltipBehavior: TooltipBehavior(
                                    enable: true,
                                  ),
                                )
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text("Overview", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        ),
                        trailing: CupertinoButton(
                            onPressed: () {

                            },
                            child: Icon(CupertinoIcons.calendar)
                        ),
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
                                  child: Text("",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('',
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("0%",
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
                                  majorGridLines: const MajorGridLines(width: 0)
                              ),
                              series: <ChartSeries>[
                                StackedColumnSeries<ChartSampleData, String>(
                                    dataSource: _chartData1,
                                    xValueMapper: (ChartSampleData view1, _) => view1.x,
                                    yValueMapper: (ChartSampleData view1, _) => view1.y,
                                  name: 'Production'
                                ),
                                StackedColumnSeries<ChartSampleData, String>(
                                    dataSource: _chartData1,
                                    xValueMapper: (ChartSampleData view1, _) => view1.x,
                                    yValueMapper: (ChartSampleData view1, _) => view1.y2,
                                    name: 'Presplit'
                                ),
                                StackedColumnSeries<ChartSampleData, String>(
                                    dataSource: _chartData1,
                                    xValueMapper: (ChartSampleData view1, _) => view1.x,
                                    yValueMapper: (ChartSampleData view1, _) => view1.y3,
                                    name: 'Tender'
                                ),
                              ],
                              tooltipBehavior: TooltipBehavior(
                                enable: true,
                              ),
                            )
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        ));
  }
}

