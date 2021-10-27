class BarChartData {
  BarChartData( this.month, this.production, this.presplit, this.tender);
  final String month;
  final double production;
  final double presplit;
  final double tender;
}

List<BarChartData> getDefaultBarSeries() {
  final List<BarChartData> chartData1 = <BarChartData>[
    BarChartData("Jan", 112579.5, 6203.25, 118782.8),
    BarChartData("Feb", 118858.3, 1454.7, 120313),
    BarChartData("Mar", 107372.3, 8806, 116178.3),
    BarChartData("Apr", 120488.4, 11291.5, 130876.6),
    BarChartData("May", 130564.8, 3452.1, 134016.9),
    BarChartData("Jun", 120084.2, 0, 120084.2),
  ];
  return chartData1;
}

double presplitTotal(List<BarChartData> chartData) {
  double total = 0;

  for(int i=0; i < chartData.length; i++) {
    total += chartData[i].presplit;
  }

  return total;
}

double prodTotal(List<BarChartData> chartData) {
  double total = 0;

  for(int i=0; i < chartData.length; i++) {
    total += chartData[i].production;
  }

  return total;
}

double tenTotal(List<BarChartData> chartData) {
  double total = 0;

  for(int i=0; i < chartData.length; i++) {
    total += chartData[i].tender;
  }

  return total;
}