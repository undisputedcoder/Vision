import 'package:apple/Data/chart1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class View2 extends StatefulWidget {
  const View2({Key? key}) : super(key: key);

  @override
  _View2State createState() => _View2State();
}

class _View2State extends State<View2> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Target Overview')
      ),
      body: Container(
        child: Center(
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              title: ChartTitle(text: 'Production & Presplit vs Tender'),
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
    );
  }
}
