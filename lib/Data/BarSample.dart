import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSampleData {
  ChartSampleData( this.x, this.y, this.y2, this.y3);
  final String x;
  final double y; //production
  final double y2; //presplit
  final double y3; //tender
}

List<ChartSampleData> getDefaultBarSeries() {
  final List<ChartSampleData> chartData1 = <ChartSampleData>[
    ChartSampleData("Jan", 112579.5, 6203.25, 118782.8),
    ChartSampleData("Feb", 118858.3, 1454.7, 120313),
    ChartSampleData("Mar", 107372.3, 8806, 116178.3),
    ChartSampleData("Apr", 120488.4, 11291.5, 130876.6),
    ChartSampleData("May", 130564.8, 3452.1, 134016.9),
    ChartSampleData("Jun", 120084.2, 0, 120084.2),
  ];
  return chartData1;
}