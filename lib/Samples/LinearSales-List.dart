import 'package:charts_flutter/flutter.dart' as charts;
import 'package:apple/Samples/LinearSales.dart';

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
  charts.Series(
    id: 'Sales',
    domainFn: (LinearSales sales, _) => sales.year,
    measureFn: (LinearSales sales, _) => sales.sales,
    radiusPxFn: (LinearSales sales, _) => sales.radius,
    data: linearSalesList,
    colorFn: (LinearSales sales, _) {
      final bucket = sales.sales / 300;

      if (bucket < 1 / 3) {
        return charts.Color.fromHex(code: "#F57C00");
      } else if (bucket < 2 / 3) {
        return charts.Color.fromHex(code: "#FFA000");
      } else {
        return charts.Color.fromHex(code: "#FFCA28");
      }
    },
  )
];