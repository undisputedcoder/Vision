import 'package:charts_flutter/flutter.dart' as charts;
import 'package:apple/Samples/TimeSeriesSales.dart';

final List<TimeSeriesSales> data = [
  new TimeSeriesSales(new DateTime(2017, 9, 19), 30),
  new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
  new TimeSeriesSales(new DateTime(2017, 10, 3), 40),
  new TimeSeriesSales(new DateTime(2017, 10, 10), 32),
  new TimeSeriesSales(new DateTime(2017, 10, 12), 40),
  new TimeSeriesSales(new DateTime(2017, 10, 20), 27),
  new TimeSeriesSales(new DateTime(2017, 10, 29), 40),
  new TimeSeriesSales(new DateTime(2017, 11, 5), 29),
];

List<charts.Series<TimeSeriesSales, DateTime>> timeSeries = [
  charts.Series(
    id: 'Sales',
    colorFn: (_, __) => charts.Color.fromHex(code: "#fb8c00"),
    domainFn: (TimeSeriesSales sales, _) => sales.time,
    measureFn: (TimeSeriesSales sales, _) => sales.sales,
    data: data,
  )
];