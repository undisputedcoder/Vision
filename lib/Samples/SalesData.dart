import 'package:syncfusion_flutter_charts/charts.dart';

class _ChartData {
  _ChartData(this.x, this.y, this.y2);
  final double x;
  final double y;
  final double y2;
}

List<LineSeries<_ChartData, num>> getDefaultLineSeries() {
  final List<_ChartData> chartData = <_ChartData>[
    _ChartData(2005, 21, 28),
    _ChartData(2006, 24, 44),
    _ChartData(2007, 36, 48),
    _ChartData(2008, 38, 50),
    _ChartData(2009, 54, 66),
    _ChartData(2010, 57, 78),
    _ChartData(2011, 70, 84)
  ];
  return <LineSeries<_ChartData, num>>[
    LineSeries<_ChartData, num>(
        animationDuration: 2500,
        dataSource: chartData,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        width: 2,
        name: 'Germany',
        markerSettings: const MarkerSettings(isVisible: true)),
    LineSeries<_ChartData, num>(
        animationDuration: 2500,
        dataSource: chartData,
        width: 2,
        name: 'England',
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y2,
        markerSettings: const MarkerSettings(isVisible: true))
  ];
}