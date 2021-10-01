import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSampleData {
  ChartSampleData({required this.x, this.y, this.secondSeriesYValue, this.thirdSeriesYValue});
  final String x;
  final int? y;
  final int? secondSeriesYValue;
  final int? thirdSeriesYValue;
}

List<BarSeries<ChartSampleData, String>> getDefaultBarSeries() {
  final List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(
        x: 'France',
        y: 84452000,
        secondSeriesYValue: 82682000,
        thirdSeriesYValue: 86861000),
    ChartSampleData(
        x: 'Spain',
        y: 68175000,
        secondSeriesYValue: 75315000,
        thirdSeriesYValue: 81786000),
    ChartSampleData(
        x: 'US',
        y: 77774000,
        secondSeriesYValue: 76407000,
        thirdSeriesYValue: 76941000),
    ChartSampleData(
        x: 'Italy',
        y: 50732000,
        secondSeriesYValue: 52372000,
        thirdSeriesYValue: 58253000),
    ChartSampleData(
        x: 'Mexico',
        y: 32093000,
        secondSeriesYValue: 35079000,
        thirdSeriesYValue: 39291000),
    ChartSampleData(
        x: 'UK',
        y: 34436000,
        secondSeriesYValue: 35814000,
        thirdSeriesYValue: 37651000),
  ];
  return <BarSeries<ChartSampleData, String>>[
    BarSeries<ChartSampleData, String>(
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        name: '2015'),
    BarSeries<ChartSampleData, String>(
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
        name: '2016'),
    BarSeries<ChartSampleData, String>(
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.thirdSeriesYValue,
        name: '2017')
  ];
}