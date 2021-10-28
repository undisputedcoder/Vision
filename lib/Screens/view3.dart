import 'package:apple/Data/chart3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class View3 extends StatefulWidget {
  const View3({Key? key}) : super(key: key);

  @override
  _View3State createState() => _View3State();
}

class _View3State extends State<View3> {
  late List<BarChartData> _chartData1;

  @override
  void initState() {
    _chartData1 = getDefaultBarSeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Target Overview'),
      ),
      body: Container(
        child: Center(
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              title: ChartTitle(
                  text: 'Production & Presplit Breakdown vs Tender',
                textStyle: TextStyle(
                  fontSize: 13
                )
              ),
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0)),
              series: <ChartSeries>[
                StackedColumnSeries<BarChartData, String>(
                    groupName: 'Production',
                    dataSource: _chartData1,
                    xValueMapper: (BarChartData view1, _) =>
                    view1.month,
                    yValueMapper: (BarChartData view1, _) =>
                    view1.production,
                    name: 'Production'),
                StackedColumnSeries<BarChartData, String>(
                    groupName: 'Tender',
                    dataSource: _chartData1,
                    xValueMapper: (BarChartData view1, _) =>
                    view1.month,
                    yValueMapper: (BarChartData view1, _) =>
                    view1.tender,
                    name: 'Tender'),
                StackedColumnSeries<BarChartData, String>(
                    groupName: 'Production',
                    dataSource: _chartData1,
                    xValueMapper: (BarChartData view1, _) =>
                    view1.month,
                    yValueMapper: (BarChartData view1, _) =>
                    view1.presplit,
                    name: 'Presplit'),
              ],
              tooltipBehavior: TooltipBehavior(
                enable: true,
              ),
            )),
      ),
    );
  }
}
