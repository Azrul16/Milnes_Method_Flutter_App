import 'package:flutter/material.dart';
import 'milnes_method.dart';
import 'package:fl_chart/fl_chart.dart';

class MilnesScreen extends StatefulWidget {
  const MilnesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MilnesScreenState createState() => _MilnesScreenState();
}

class _MilnesScreenState extends State<MilnesScreen> {
  final _x0Controller = TextEditingController();
  final _y0Controller = TextEditingController();
  final _hController = TextEditingController();
  final _stepsController = TextEditingController();

  List<double>? results;
  List<double>? xValues;

  void computeResults() {
    double x0 = double.parse(_x0Controller.text);
    double y0 = double.parse(_y0Controller.text);
    double h = double.parse(_hController.text);
    int steps = int.parse(_stepsController.text);

    MilnesMethod milne = MilnesMethod();
    setState(() {
      results = milne.milnesMethod(x0: x0, y0: y0, h: h, steps: steps);
      xValues = List.generate(steps, (index) => x0 + index * h);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Milne\'s Method Solver')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _x0Controller,
              decoration: const InputDecoration(labelText: 'Initial x (x0)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _y0Controller,
              decoration: const InputDecoration(labelText: 'Initial y (y0)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _hController,
              decoration: const InputDecoration(labelText: 'Step size (h)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _stepsController,
              decoration: const InputDecoration(labelText: 'Number of steps'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: computeResults,
              child: const Text('Compute'),
            ),
            if (results != null)
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: LineChart(
                        LineChartData(
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) =>
                                    Text(value.toStringAsFixed(1)),
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) =>
                                    Text(value.toStringAsFixed(1)),
                              ),
                            ),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(color: Colors.black),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: List.generate(
                                results!.length,
                                (index) =>
                                    FlSpot(xValues![index], results![index]),
                              ),
                              isCurved: true,
                              barWidth: 3,
                              dotData: const FlDotData(show: true),
                              belowBarData: BarAreaData(show: false),
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Computed Values:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: results!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                'x$index = ${xValues![index]}, y$index = ${results![index]}'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
