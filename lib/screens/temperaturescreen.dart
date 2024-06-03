import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nextgen_living1/widgets/appbar.dart';

class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen({Key? key}) : super(key: key);

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  DatabaseReference humidityref =
      FirebaseDatabase.instance.ref('Temp/humidity');
  DatabaseReference tempref = FirebaseDatabase.instance.ref('Temp/temp');
  Object temperature = 0;
  Object humidity = 0;
  final List<double> temperatureData = [20, 22, 21, 23, 24, 25, 26];
  final List<String> dates = [
    '2022-03-20',
    '2022-03-21',
    '2022-03-22',
    '2022-03-23',
    '2022-03-24',
    '2022-03-25',
    '2022-03-26'
  ];

  @override
  void initState() {
    super.initState();
    humidityref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print('Data received: $data');
      if (data != null) {
        setState(() {
          humidity = data;
        });
      }
    });
    tempref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print('Data received: $data');
      if (data != null) {
        setState(() {
          temperature = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComp(),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.grey[300]!],
            stops: const [0.0, 0.7],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20), // Add top margin
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Card(
                  elevation: 5, // Add some elevation for a shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.blue.withOpacity(0.5),
                          Colors.white.withOpacity(0.5)
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Row(
                              children: <Widget>[
                                Icon(Icons.thermostat),
                                SizedBox(width: 8),
                                Text(
                                  'Temperature',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Text(
                              '$temperature °C',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Row(
                              children: <Widget>[
                                Icon(Icons.wb_sunny),
                                SizedBox(width: 8),
                                Text(
                                  'Humidity',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Text(
                              '$humidity %',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Temperature of Last 7 Days',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blue, Colors.grey[300]!],
                          stops: const [0.0, 0.7],
                        ),
                      ),
                      height: 200, // Set a fixed height for the chart
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: false),
                          titlesData: const FlTitlesData(show: false),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots:
                                  temperatureData.asMap().entries.map((entry) {
                                return FlSpot(
                                    entry.key.toDouble(), entry.value);
                              }).toList(),
                              isCurved: true,
                              color: Colors.blue,
                              barWidth: 4,
                              isStrokeCapRound: true,
                              dotData: const FlDotData(show: true),
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: dates.map((date) {
                        return Text(
                          date,
                          style: const TextStyle(fontSize: 8),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
