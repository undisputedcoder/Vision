import 'package:apple/Data/chart1.dart';
import 'package:apple/Data/info.dart';
import 'package:apple/Templates/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class View1 extends StatefulWidget {
  const View1({Key? key}) : super(key: key);

  @override
  _View1State createState() => _View1State();
}

class _View1State extends State<View1> {
  DateTime current = DateTime.now();
  double _production = roundDouble(productionTotal(chartData), 2);
  double _tender = roundDouble(tenderTotal(chartData), 2);

  displayProductionTotal() {
    setState(() {
      _production = productionTotal(chartData);
    });
  }

  displayTenderTotal() {
    setState(() {
      _tender = tenderTotal(chartData);
    });
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
              title: ChartTitle(text: 'Production & Presplit vs Tender'),
              legend: Legend(
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                  position: LegendPosition.bottom),
              primaryXAxis: DateTimeAxis(
                  intervalType: DateTimeIntervalType.days,
                  interval: 7,
                  majorGridLines: const MajorGridLines(width: 0)),
              primaryYAxis: NumericAxis(
                  labelFormat: '{value} m',
                  axisLine: const AxisLine(width: 0),
                  majorTickLines: const MajorTickLines(
                      color: Colors.transparent)),
              series: getLineSeries(),
              tooltipBehavior: TooltipBehavior(
                enable: true,
              ),
            )),
      ),
    );
  }
}
