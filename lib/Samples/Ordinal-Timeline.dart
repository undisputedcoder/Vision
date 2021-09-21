import 'package:charts_flutter/flutter.dart' as charts;
import 'package:apple/Samples/OrdinalSales.dart';

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
    colorFn: (_, __) => charts.Color.fromHex(code: "#F57C00"),
    domainFn: (OrdinalSales sales, _) => sales.year,
    measureFn: (OrdinalSales sales, _) => sales.sales,
    data: desktopSalesData,
  ),
  charts.Series(
    id: 'Tablet',
    colorFn: (_, __) => charts.Color.fromHex(code: "#FFA000"),
    domainFn: (OrdinalSales sales, _) => sales.year,
    measureFn: (OrdinalSales sales, _) => sales.sales,
    data: tableSalesData,
  ),
  charts.Series(
    id: 'Mobile',
    colorFn: (_, __) => charts.Color.fromHex(code: "#FFCA28"),
    domainFn: (OrdinalSales sales, _) => sales.year,
    measureFn: (OrdinalSales sales, _) => sales.sales,
    data: mobileSalesData,
  ),
];