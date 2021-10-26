import 'package:apple/Alert/alert.dart';
import 'package:apple/Data/BarSample.dart';
import 'package:apple/Data/SalesData.dart';
import 'package:apple/Data/info.dart';
import 'package:apple/Templates/card.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apple/Screens/profile.dart';
import 'package:apple/Screens/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

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
  double _production = roundDouble(productionTotal(chartData), 2);
  double _tender = roundDouble(tenderTotal(chartData), 2);
  late List<ChartSampleData> _chartData1;
  final DateTime _dateMin = DateTime(2021,1,1);
  final DateTime _dateMax = DateTime(2021,1,31);
  final SfRangeValues _dateValues = SfRangeValues(
      DateTime(2021,1,1), 
      DateTime(2021,1,31)
  );

  displayProductionTotal() {
    setState(() {
      _production = productionTotal(chartData);
    });
  }

  displayTenderTotal() {
    setState(() {
      _tender = tenderTotal(chartData);
    });
  }

  @override
  void initState() {
    _chartData1 = getDefaultBarSeries();
    super.initState();
    checkUserAccelerometer(context);
  }
  
  String dateFormattedGenerator(int fromToday){
    DateTime result = current.add(Duration(days: fromToday));
    String resultFormatted = DateFormat('EEEE, dd MMM').format(result);
    return resultFormatted;
  }
  
  DateTime dateTimeGenerator(int fromToday){
    DateTime result = current.add(Duration(days: fromToday));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    //*******CURRENT DATE*************//
    String currentFormatted = DateFormat('EEEE, dd MMM').format(current);
    String currentFormattedShort = DateFormat('dd MMM').format(current);

    //*******30 DAYS FROM TODAY*******//
    DateTime thirtyDays = current.add(Duration(days: 30));
    String thirtyDaysFormatted = DateFormat('EEEE, dd MMM').format(thirtyDays);
    String thirtyDaysFormattedShort = DateFormat('dd MMM').format(thirtyDays);

    bool _lights = false;

    return CupertinoPageScaffold(
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
                              child: info('Total Production ', _production, 20.7)
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showTenderInfo(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                              child: info('Total Tender ', _tender, 10.2)
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
                              labelFormat: '{value} m',
                              axisLine: const AxisLine(width: 0),
                              majorTickLines: const MajorTickLines(
                                  color: Colors.transparent)),
                          series: getLineSeries(),
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                          ),
                        )),
                      ),
                    ]),
                  ),
                ),
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
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return Container(
                                  height: MediaQuery.of(context).size.height * 0.75,
                                  child: DefaultTabController(
                                      length: 3,
                                      child: Scaffold(
                                        appBar: AppBar(
                                          bottom: const TabBar(
                                            tabs: [
                                              Tab(text: 'Week'),
                                              Tab(text: 'Month'),
                                              Tab(text: 'Custom'),
                                            ],
                                          ),
                                          title: const Text('Date Range'),
                                        ),
                                        body: TabBarView(
                                          children: [
                                            Column(
                                              children: [
                                                InkWell(
                                                  child: ListTile(
                                                    title: Text("Last 7 days"),
                                                    //subtitle: Text("$lastWeekFormatted - $yesterdayFormatted"),
                                                    subtitle: Text(dateFormattedGenerator(-7)+" - "+dateFormattedGenerator(-1)),
                                                  ),
                                                ),
                                                Divider(
                                                  height: 1.0,
                                                  color: CupertinoColors.systemGrey,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                ListTile(
                                                  leading: Text('Compare',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500
                                                      )
                                                  ),
                                                  trailing: CupertinoSwitch(
                                                    value: _lights,
                                                    onChanged: (bool value) {
                                                      setState(() {
                                                        _lights = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                InkWell(
                                                  child: ListTile(
                                                    title: Text("Preceding period"),
                                                    subtitle: Text(dateFormattedGenerator(-14)+" - "+dateFormattedGenerator(-8)),
                                                  ),
                                                ),
                                                Divider(
                                                  height: 1.0,
                                                  color: CupertinoColors.systemGrey,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                InkWell(
                                                  child: ListTile(
                                                    title: Text("Last 30 days"),
                                                    subtitle: Text(dateFormattedGenerator(-30)+" - "+dateFormattedGenerator(-1)),
                                                  ),
                                                ),
                                                Divider(
                                                  height: 1.0,
                                                  color: CupertinoColors.systemGrey,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                ListTile(
                                                  leading: Text('Compare',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500
                                                      )
                                                  ),
                                                  trailing: CupertinoSwitch(
                                                    onChanged: (bool value) {
                                                      setState(() {
                                                        _lights = value;
                                                      });
                                                    },
                                                    value: _lights,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                InkWell(
                                                  child: ListTile(
                                                    title: Text("Preceding period"),
                                                    subtitle: Text(dateFormattedGenerator(-60)+" - "+dateFormattedGenerator(-31)),
                                                  ),
                                                ),
                                                Divider(
                                                  height: 1.0,
                                                  color: CupertinoColors.systemGrey,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
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
                                                Divider(
                                                  height: 1.0,
                                                  color: CupertinoColors.systemGrey,
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
                                                Divider(
                                                  height: 1.0,
                                                  color: CupertinoColors.systemGrey,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                ListTile(
                                                  leading: Text('Compare',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500
                                                      )
                                                  ),
                                                  trailing: CupertinoSwitch(
                                                    onChanged: (bool value) {
                                                      setState(() {
                                                        _lights = value;
                                                      });
                                                    },
                                                    value: _lights,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
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
                                                    title: Text("Preceding period"),
                                                    subtitle:
                                                    Text("$thirtyDaysFormatted"),
                                                  ),
                                                ),
                                                Divider(
                                                  height: 1.0,
                                                  color: CupertinoColors.systemGrey,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
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
                                child: info('Total Production ', _production, 20.7)
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
                              title: ChartTitle(text: 'Tender'),
                              legend: Legend(
                                  isVisible: true,
                                  overflowMode: LegendItemOverflowMode.wrap,
                                  position: LegendPosition.bottom),
                              primaryXAxis: DateTimeAxis(
                                 /* maximum: dateTimeGenerator(-30),
                                  minimum: dateTimeGenerator(-1),*/ //tester
                                  intervalType: DateTimeIntervalType.days,
                                  interval: 7,
                                  majorGridLines: const MajorGridLines(width: 0)),
                              primaryYAxis: NumericAxis(
                                  labelFormat: '{value} m',
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
                          onPressed: () {
                            showHelp(context);
                          },
                          child: Icon(CupertinoIcons.info_circle)),
                    ),
                    Divider(
                      height: 1.0,
                      color: CupertinoColors.systemGrey,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return Container(
                                height: MediaQuery.of(context).size.height * 0.75,
                                child: DefaultTabController(
                                  length: 3,
                                  child: Scaffold(
                                    appBar: AppBar(
                                      bottom: const TabBar(
                                        tabs: [
                                          Tab(text: 'Week'),
                                          Tab(text: 'Month'),
                                          Tab(text: 'Custom'),
                                        ],
                                      ),
                                      title: const Text('Date Range'),
                                    ),
                                    body: TabBarView(
                                      children: [
                                        Column(
                                          children: [
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
                                                title: Text("Last 7 days"),
                                                subtitle: Text("$currentFormatted"),
                                              ),
                                            ),
                                            Divider(
                                              height: 1.0,
                                              color: CupertinoColors.systemGrey,
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
                                                title: Text("Last week"),
                                                subtitle:
                                                Text("$thirtyDaysFormatted"),
                                              ),
                                            ),
                                            Divider(
                                              height: 1.0,
                                              color: CupertinoColors.systemGrey,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            ListTile(
                                              leading: Text('Compare',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500
                                                )
                                              ),
                                              trailing: CupertinoSwitch(
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    _lights = value;
                                                  });
                                                },
                                                value: _lights,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
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
                                                title: Text("Preceding period"),
                                                subtitle:
                                                Text("$thirtyDaysFormatted"),
                                              ),
                                            ),
                                            Divider(
                                              height: 1.0,
                                              color: CupertinoColors.systemGrey,
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
                                                title: Text("Two weeks ago"),
                                                subtitle:
                                                Text("$thirtyDaysFormatted"),
                                              ),
                                            ),
                                            Divider(
                                              height: 1.0,
                                              color: CupertinoColors.systemGrey,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
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
                                                title: Text("Last 30 days"),
                                                subtitle: Text("$currentFormatted"),
                                              ),
                                            ),
                                            Divider(
                                              height: 1.0,
                                              color: CupertinoColors.systemGrey,
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
                                                title: Text("Last month"),
                                                subtitle:
                                                Text("$thirtyDaysFormatted"),
                                              ),
                                            ),
                                            Divider(
                                              height: 1.0,
                                              color: CupertinoColors.systemGrey,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            ListTile(
                                              leading: Text('Compare',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500
                                                  )
                                              ),
                                              trailing: CupertinoSwitch(
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    _lights = value;
                                                  });
                                                },
                                                value: _lights,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
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
                                                title: Text("Preceding period"),
                                                subtitle:
                                                Text("$thirtyDaysFormatted"),
                                              ),
                                            ),
                                            Divider(
                                              height: 1.0,
                                              color: CupertinoColors.systemGrey,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
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
                                            Divider(
                                              height: 1.0,
                                              color: CupertinoColors.systemGrey,
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
                                            Divider(
                                              height: 1.0,
                                              color: CupertinoColors.systemGrey,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            ListTile(
                                              leading: Text('Compare',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500
                                                  )
                                              ),
                                              trailing: CupertinoSwitch(
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    _lights = value;
                                                  });
                                                },
                                                value: _lights,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
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
                                                title: Text("Preceding period"),
                                                subtitle:
                                                Text("$thirtyDaysFormatted"),
                                              ),
                                            ),
                                            Divider(
                                              height: 1.0,
                                              color: CupertinoColors.systemGrey,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
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
                      height: 15.0,
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
                            child: info('Total Production ', 709645, 9.8)
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
                        title: ChartTitle(text: 'Title'),
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
