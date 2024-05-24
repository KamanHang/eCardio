import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ecardio/model/MedicalReport.dart';
import 'package:ecardio/services/MedicalReportService.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ecardio/Providers/ProvidePatientInfo.dart';
import 'package:fl_chart/fl_chart.dart';

class DataVisualization extends StatefulWidget {
  const DataVisualization({Key? key}) : super(key: key);

  @override
  State<DataVisualization> createState() => _DataVisualizationState();
}

class _DataVisualizationState extends State<DataVisualization> {
  List<MedicalReportModel> chartData = [];
  List<String> testList = [];
  List<String> acronymList = [];
  List<double> resultList = [];
  bool isLoading = true;
  String tableDataJsonString = "";
  String liverResult = "";
  List<dynamic> foodsToAvoid = [];
  String selectedView = 'Weekly'; // Default selected view

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Load JSON data from asset
    String jsonData =
        await rootBundle.loadString('assets/JsonFile/foodData.json');
    // Parse JSON data
    List<dynamic> jsonList = json.decode(jsonData);
    setState(() {
      foodsToAvoid = jsonList;
      print(foodsToAvoid);
    });
    final patientProvider =
        Provider.of<PatientProvider>(context, listen: false);
    final patientId = patientProvider.patientDetails?.patientId;
    print('Patient ID: $patientId');

    try {
      final reports =
          await MedicalReportService.fetchReportsByPatientId(patientId!);
      print(reports);
      if (reports != null) {
        setState(() {
          chartData = reports;
          tableDataJsonString = json.encode(chartData);

          print(tableDataJsonString);

          // Extract test and result values into separate lists
          testList = chartData.map((report) => report.test ?? '').toList();
          print(testList);
          acronymList = [
            'TB',
            'DB',
            'ALP',
            'SGPT',
            'SGOT',
            'TP',
            'SA'
          ]; // Acronym list based on provided data
          resultList = chartData
              .map((report) => double.parse(report.result ?? '0'))
              .toList();

          print(resultList);

          checkBillirubin();
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  String checkBillirubin() {
    for (int i = 0; i < testList.length; i++) {
      String testType = testList[i];
      double result = resultList[i];
      if (testType == 'Total Billirubin' && result > 1.1) {
        print("High");
        return liverResult =
            "You have high Billirubin. Hence, High Jaundice";
      } else if (testType == 'Total Billirubin' && result < 0.1) {
        return liverResult = "High Jaundice";
      }
    }
    return liverResult; // Return empty string if conditions are not met
  }

  void changeView(String view) {
    setState(() {
      selectedView = view;
    });
    // Call the method to fetch data according to the selected view
    // fetchDataByView(view);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Visualization'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: Text("No any records to show in data")) 
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Choose Category:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButton<String>(
                        value: selectedView,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            changeView(newValue);
                          }
                        },
                        items: <String>['Weekly', 'Monthly']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Liver Test Results',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 50),
                  Expanded(
                    child: SizedBox(
                      height: 300,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          groupsSpace: 12,
                          barTouchData: BarTouchData(
                            enabled: false,
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.white,
                            ),
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (context, value) =>
                                  const TextStyle(
                                color:
                                    Colors.black87, // Changed to black color
                                fontWeight: FontWeight.bold,
                                fontSize: 14, // Increased font size
                                fontFamily: 'Poppins',
                              ),
                              margin: 20,
                              getTitles: (double value) {
                                return acronymList[
                                    value.toInt()]; // Changed to acronym list
                              },
                            ),
                            leftTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barGroups: resultList
                              .asMap()
                              .map(
                                (key, value) => MapEntry(
                                  key,
                                  BarChartGroupData(
                                    x: key,
                                    barRods: [
                                      BarChartRodData(
                                        y: value,
                                        width: 25, // Changed width
                                        borderRadius:
                                            const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        ),
                                        colors: [
                                          Colors.blue,
                                          Colors.green,
                                        ],
                                      ),
                                    ],
                                    showingTooltipIndicators: [0],
                                  ),
                                ),
                              )
                              .values
                              .toList(),
                        ),
                        swapAnimationDuration: Duration(
                          milliseconds: 150,
                        ), // Set animation duration for swap
                        swapAnimationCurve: Curves
                            .linear, // Set animation curve for swap
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Detailed Results',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            liverResult,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 12),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Foods to Avoid',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: foodsToAvoid.length,
                            itemBuilder: (context, index) {
                              var food = foodsToAvoid[index];
                              return ListTile(
                                leading: Image.asset(
                                  "assets/images/Dinner.png",
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  food['food'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  food['description'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
