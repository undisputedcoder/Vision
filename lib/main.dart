import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: Home(),
    );
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
      backgroundColor: Colors.grey.shade100,
        navigationBar: const CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.all(2.0),
          middle: CupertinoSearchTextField(),
          trailing: Icon(
            CupertinoIcons.settings,
          ),
          backgroundColor: CupertinoColors.extraLightBackgroundGray,
        ),
      child: CupertinoScrollbar(
        thickness: 4,
        child: ListView (
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Card(
              child: Container(
                height: 400,
                child: Center(
                  child: charts.BarChart(
                    timeline,
                    animate: true,
                    vertical: false,
                    behaviors: [
                      new charts.ChartTitle("Top title",
                        subTitle: "Top sub-title",
                        behaviorPosition: charts.BehaviorPosition.top,
                        titleOutsideJustification: charts.OutsideJustification.middle,
                        innerPadding: 18,
                      ),
                      new charts.ChartTitle('Bottom title',
                          behaviorPosition: charts.BehaviorPosition.bottom,
                          titleOutsideJustification: charts.OutsideJustification.middleDrawArea
                      ),
                      new charts.ChartTitle('Start title',
                          behaviorPosition: charts.BehaviorPosition.start,
                          titleOutsideJustification: charts.OutsideJustification.middleDrawArea
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
                height: 50.0
            ),
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
                        position: charts.BehaviorPosition.bottom
                      ),
                      new charts.ChartTitle("Top title",
                        subTitle: "Top sub-title",
                        behaviorPosition: charts.BehaviorPosition.top,
                        titleOutsideJustification: charts.OutsideJustification.middle,
                        innerPadding: 18,
                      ),
                      new charts.ChartTitle('Bottom title',
                          behaviorPosition: charts.BehaviorPosition.bottom,
                          titleOutsideJustification: charts.OutsideJustification.middleDrawArea
                      ),
                      new charts.ChartTitle('Start title',
                          behaviorPosition: charts.BehaviorPosition.start,
                          titleOutsideJustification: charts.OutsideJustification.middleDrawArea
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
                height: 50.0
            ),
            Card(
              child: Container(
                height: 400,
                child: Center(
                  child: charts.ScatterPlotChart(
                    sales,
                    animate: true,
                    behaviors: [
                      new charts.ChartTitle("Top title",
                        subTitle: "Top sub-title",
                        behaviorPosition: charts.BehaviorPosition.top,
                        titleOutsideJustification: charts.OutsideJustification.middle,
                        innerPadding: 18,
                      ),
                      new charts.ChartTitle('Bottom title',
                          behaviorPosition: charts.BehaviorPosition.bottom,
                          titleOutsideJustification: charts.OutsideJustification.middleDrawArea
                      ),
                      new charts.ChartTitle('Start title',
                          behaviorPosition: charts.BehaviorPosition.start,
                          titleOutsideJustification: charts.OutsideJustification.middleDrawArea
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: Center(
                child: Container(

                ),
              ),
            )
          ],
        ),
      )
    );
  }
}

class Earnings {
  final String year;
  final double earning;

  Earnings({required this.year, required this.earning});

}

final List<Earnings> listEarnings = [
  Earnings(year: "14", earning: 73),
  Earnings(year: "13", earning: 43.5),
  Earnings(year: "12", earning: 42),
  Earnings(year: "11", earning: 38),
  Earnings(year: "10", earning: 30),
  Earnings(year: "09", earning: 21),
  Earnings(year: "08", earning: 18.2),
];

List<charts.Series<Earnings, String>> timeline = [
  charts.Series(
    id: "Subscribers",
    data: listEarnings,
    domainFn: (Earnings timeline, _) => timeline.year,
    measureFn: (Earnings timeline, _) =>timeline.earning,
    colorFn: (_, __) => charts.Color.fromHex(
        code: "#fb8c00"
    ),
  )
];

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

final List<OrdinalSales> desktopSalesData = [
  new OrdinalSales('2014', 5),
  new OrdinalSales('2015', 25),
  new OrdinalSales('2016', 100),
  new OrdinalSales('2017', 75),
];

final List<OrdinalSales> tableSalesData = [
  new OrdinalSales('2014', 25),
  new OrdinalSales('2015', 50),
  new OrdinalSales('2016', 10),
  new OrdinalSales('2017', 20),
];

final List<OrdinalSales> mobileSalesData = [
  new OrdinalSales('2014', 10),
  new OrdinalSales('2015', 15),
  new OrdinalSales('2016', 50),
  new OrdinalSales('2017', 45),
];

List<charts.Series<OrdinalSales, String>> series = [
  charts.Series(
    id: 'Desktop',
    colorFn: (_, __) => charts.Color.fromHex(
        code: "#F57C00"
    ),
    domainFn: (OrdinalSales sales, _) => sales.year,
    measureFn: (OrdinalSales sales, _) => sales.sales,
    data: desktopSalesData,
  ),
  charts.Series(
    id: 'Tablet',
    colorFn: (_, __) => charts.Color.fromHex(
        code: "#FFA000"
    ),
    domainFn: (OrdinalSales sales, _) => sales.year,
    measureFn: (OrdinalSales sales, _) => sales.sales,
    data: tableSalesData,
  ),
  charts.Series(
    id: 'Mobile',
    colorFn: (_, __) => charts.Color.fromHex(
        code: "#FFCA28"
    ),
    domainFn: (OrdinalSales sales, _) => sales.year,
    measureFn: (OrdinalSales sales, _) => sales.sales,
    data: mobileSalesData,
  ),
];

class LinearSales {
  final int year;
  final int sales;
  final double radius;

  LinearSales(this.year, this.sales, this.radius);
}

final List<LinearSales> linearSalesList = [
  new LinearSales(0, 5, 3.0),
  new LinearSales(10, 25, 5.0),
  new LinearSales(12, 75, 4.0),
  new LinearSales(13, 225, 5.0),
  new LinearSales(16, 50, 4.0),
  new LinearSales(24, 75, 3.0),
  new LinearSales(25, 100, 3.0),
  new LinearSales(34, 150, 5.0),
  new LinearSales(37, 10, 4.5),
  new LinearSales(45, 300, 8.0),
  new LinearSales(52, 15, 4.0),
  new LinearSales(56, 200, 7.0),
];

List<charts.Series<LinearSales, int>> sales = [
  charts.Series (
    id: 'Sales',
    domainFn: (LinearSales sales, _) => sales.year,
    measureFn: (LinearSales sales, _) => sales.sales,
    radiusPxFn: (LinearSales sales, _) => sales.radius,
    data: linearSalesList,
    colorFn: (LinearSales sales, _) {

      final bucket = sales.sales / 300;

      if (bucket < 1 / 3) {
        return charts.Color.fromHex(
            code: "#F57C00"
        );
      } else if (bucket < 2 / 3) {
        return charts.Color.fromHex(
            code: "#FFA000"
        );
      } else {
        return charts.Color.fromHex(
            code: "#FFCA28"
        );
      }
    },
  )
];


