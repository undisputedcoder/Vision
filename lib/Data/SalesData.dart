import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

class _ChartData {
  _ChartData(this.date, this.y, this.y2);
  final DateTime date;
  final double y;
  final double y2;

}

final List<_ChartData> chartData = <_ChartData>[
  _ChartData(DateTime.parse("2021-01-01"), 3930.2, 3930.2),
  _ChartData(DateTime.parse("2021-01-02"), 5281.5, 5281.5),
  _ChartData(DateTime.parse("2021-01-03"), 6393.7, 6393.7),
  _ChartData(DateTime.parse("2021-01-04"), 4861.1, 4861.1),
  _ChartData(DateTime.parse("2021-01-05"), 5668.35, 5668.35),
  _ChartData(DateTime.parse("2021-01-06"), 3670.2, 3670.2),
  _ChartData(DateTime.parse("2021-01-07"), 3241, 3241),
  _ChartData(DateTime.parse("2021-01-08"), 4310, 4310),
  _ChartData(DateTime.parse("2021-01-09"), 2972.9, 2972.9),
  _ChartData(DateTime.parse("2021-01-10"), 2932.65, 2932.65),
  _ChartData(DateTime.parse("2021-01-11"), 4685.05, 4685.05),
  _ChartData(DateTime.parse("2021-01-12"), 2397.15, 2397.15),
  _ChartData(DateTime.parse("2021-01-13"), 2680.9, 2680.9),
  _ChartData(DateTime.parse("2021-01-14"), 2784.45, 2784.45),
  _ChartData(DateTime.parse("2021-01-15"), 3916.8, 3916.8),
  _ChartData(DateTime.parse("2021-01-16"), 3390.4, 3390.4),
  _ChartData(DateTime.parse("2021-01-17"), 3904.7, 3904.7),
  _ChartData(DateTime.parse("2021-01-18"), 3846.2, 3846.2),
  _ChartData(DateTime.parse("2021-01-19"), 5090.5, 5090.5),
  _ChartData(DateTime.parse("2021-01-20"), 4532.6, 4532.6),
  _ChartData(DateTime.parse("2021-01-21"), 2629.9, 2629.9),
  _ChartData(DateTime.parse("2021-01-22"), 2290.5, 2290.5),
  _ChartData(DateTime.parse("2021-01-23"), 3447.1, 3447.1),
  _ChartData(DateTime.parse("2021-01-24"), 4116.5, 4116.5),
  _ChartData(DateTime.parse("2021-01-25"), 4501.4, 4501.4),
  _ChartData(DateTime.parse("2021-01-26"), 3994.7, 3994.7),
  _ChartData(DateTime.parse("2021-01-27"), 4088.7, 4088.7),
  _ChartData(DateTime.parse("2021-01-28"), 4932.25, 4932.25),
  _ChartData(DateTime.parse("2021-01-29"), 3104.55, 3104.55),
  _ChartData(DateTime.parse("2021-01-30"), 1987.8, 1987.8),
  _ChartData(DateTime.parse("2021-01-31"), 3199, 3199),
];

final List<_ChartData> chartDataFeb = <_ChartData>[
  _ChartData(DateTime.parse("2021-01-01"), 4065.3, 0),
  _ChartData(DateTime.parse("2021-01-02"), 5730.6, 0),
  _ChartData(DateTime.parse("2021-01-03"), 5091.4, 0),
  _ChartData(DateTime.parse("2021-01-04"), 3678.4, 0),
  _ChartData(DateTime.parse("2021-01-05"), 3400.1, 0),
  _ChartData(DateTime.parse("2021-01-06"), 5271.8, 0),
  _ChartData(DateTime.parse("2021-01-07"), 5535.48, 0),
  _ChartData(DateTime.parse("2021-01-08"), 5296.9, 0),
  _ChartData(DateTime.parse("2021-01-09"), 4160.04, 0),
  _ChartData(DateTime.parse("2021-01-10"), 2824.55, 0),
  _ChartData(DateTime.parse("2021-01-11"), 3052.65, 0),
  _ChartData(DateTime.parse("2021-01-12"), 3114.6, 0),
  _ChartData(DateTime.parse("2021-01-13"), 4541.65, 0),
  _ChartData(DateTime.parse("2021-01-14"), 5483.6, 0),
  _ChartData(DateTime.parse("2021-01-15"), 3990.1, 0),
  _ChartData(DateTime.parse("2021-01-16"), 6751.5, 0),
  _ChartData(DateTime.parse("2021-01-17"), 6253.5, 0),
  _ChartData(DateTime.parse("2021-01-18"), 3623.9, 0),
  _ChartData(DateTime.parse("2021-01-19"), 3341.9, 0),
  _ChartData(DateTime.parse("2021-01-20"), 4455, 0),
  _ChartData(DateTime.parse("2021-01-21"), 5322.05, 0),
  _ChartData(DateTime.parse("2021-01-22"), 4646, 0),
  _ChartData(DateTime.parse("2021-01-23"), 2172.6, 0),
  _ChartData(DateTime.parse("2021-01-24"), 2744.15, 0),
  _ChartData(DateTime.parse("2021-01-25"), 3706.9, 0),
  _ChartData(DateTime.parse("2021-01-26"), 3551.4, 0),
  _ChartData(DateTime.parse("2021-01-27"), 4414.4, 0),
  _ChartData(DateTime.parse("2021-01-28"), 4092.5, 0)
];

double productionTotal(List<_ChartData> chartData) {
  double total = 0;

  for(int i=0; i < chartData.length; i++) {
    total += chartData[i].y;
  }

  return total;
}

double tenderTotal(List<_ChartData> chartData) {
  double total = 0;

  for(int i=0; i < chartData.length; i++) {
    total += chartData[i].y2;
  }

  return total;
}

List<LineSeries<_ChartData, DateTime>> getLineSeries() {
  return <LineSeries<_ChartData, DateTime>>[
    LineSeries<_ChartData, DateTime>(
        animationDuration: 2500,
        dataSource: chartData,
        xValueMapper: (_ChartData sales, _) => sales.date,
        yValueMapper: (_ChartData sales, _) => sales.y,
        width: 2,
        name: 'Production',
        markerSettings: const MarkerSettings(isVisible: true)),
    LineSeries<_ChartData, DateTime>(
        animationDuration: 2500,
        dataSource: chartData,
        width: 2,
        name: 'Tender',
        xValueMapper: (_ChartData sales, _) => sales.date,
        yValueMapper: (_ChartData sales, _) => sales.y2,
        markerSettings: const MarkerSettings(isVisible: true))
  ];
}

double roundDouble(double value, int places){
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

List<LineSeries<_ChartData, DateTime>> getDefaultLineSeries() {
  return <LineSeries<_ChartData, DateTime>>[
    LineSeries<_ChartData, DateTime>(
        animationDuration: 2500,
        dataSource: chartData,
        xValueMapper: (_ChartData sales, _) => sales.date,
        yValueMapper: (_ChartData sales, _) => sales.y2,
        width: 2,
        name: 'Current Period'
    ),
    LineSeries<_ChartData, DateTime>(
        animationDuration: 2500,
        dataSource: chartDataFeb,
        dashArray: <double>[5,5],
        xValueMapper: (_ChartData sales, _) => sales.date,
        yValueMapper: (_ChartData sales, _) => sales.y,
        width: 2,
        name: 'Previous Period',
    ),
  ];
}