// import 'package:dental_app/core/utlis/styles.dart';
// import 'package:dental_app/features/home/widget/indicator.dart';
// import 'package:dental_app/features/patient/model/patiant_model.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dental_app/features/patient/model/class_session.dart'; // Ensure the correct import path

// class PieChartSample2 extends StatefulWidget {
//   const PieChartSample2({super.key});

//   @override
//   State<StatefulWidget> createState() => PieChart2State();
// }

// class PieChart2State extends State<PieChartSample2> {
//   int touchedIndex = -1;
//   Map<String, double> operationPercentages = {
//     'item1': 0,
//     'item2': 0,
//     'item3': 0,
//     'item4': 0,
//   };

//   @override
//   void initState() {
//     super.initState();
//     fetchOperationData();
//   }

//   Future<void> fetchOperationData() async {
//     // Fetch data from Firestore
//     QuerySnapshot snapshot =
//         await FirebaseFirestore.instance.collection('patients').get();

//     // Convert the data to a list of PatientModel objects
//     List<PatientModel> patients = snapshot.docs
//         .map((doc) => PatientModel.fromJson(doc.data() as Map<String, dynamic>))
//         .toList();

//     // Count the occurrences of each operation
//     Map<String, int> operationCounts = {
//       'item 1': 0,
//       'item 2': 0,
//       'item 3': 0,
//       'item4': 0,
//     };

//     for (var patient in patients) {
//       for (var session in patient.session!) {
//         if (session.operations != null &&
//             operationCounts.containsKey(session.operations)) {
//           operationCounts[session.operations!] =
//               operationCounts[session.operations]! + 1;
//         }
//       }
//     }

//     // Calculate the total number of operations
//     int totalOperations = operationCounts.values.reduce((a, b) => a + b);

//     // Handle division by zero case
//     Map<String, double> newOperationPercentages;
//     if (totalOperations == 0) {
//       newOperationPercentages = operationCounts.map((key, value) {
//         return MapEntry(key, 0.0);
//       });
//     } else {
//       // Calculate the percentage for each operation
//       newOperationPercentages = operationCounts.map((key, value) {
//         return MapEntry(key, (value / totalOperations) * 100);
//       });
//     }

//     // Update the state after the current frame
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       setState(() {
//         operationPercentages = newOperationPercentages;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.3,
//       child: Row(
//         children: <Widget>[
//           const SizedBox(
//             height: 18,
//           ),
//           Expanded(
//             child: AspectRatio(
//               aspectRatio: 1,
//               child: PieChart(
//                 PieChartData(
//                   pieTouchData: PieTouchData(
//                     touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                       setState(() {
//                         if (!event.isInterestedForInteractions ||
//                             pieTouchResponse == null ||
//                             pieTouchResponse.touchedSection == null) {
//                           touchedIndex = -1;
//                           return;
//                         }
//                         touchedIndex = pieTouchResponse
//                             .touchedSection!.touchedSectionIndex;
//                       });
//                     },
//                   ),
//                   borderData: FlBorderData(
//                     show: false,
//                   ),
//                   sectionsSpace: 0,
//                   centerSpaceRadius: 40,
//                   sections: showingSections(),
//                 ),
//               ),
//             ),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Indicator(
//                 color: AppColors.contentColorBlue,
//                 text: 'Item 1',
//                 isSquare: true,
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Indicator(
//                 color: AppColors.contentColorYellow,
//                 text: 'Item 2',
//                 isSquare: true,
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Indicator(
//                 color: AppColors.contentColorPurple,
//                 text: 'Item 3',
//                 isSquare: true,
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Indicator(
//                 color: AppColors.contentColorGreen,
//                 text: 'Item 4',
//                 isSquare: true,
//               ),
//               SizedBox(
//                 height: 18,
//               ),
//             ],
//           ),
//           const SizedBox(
//             width: 28,
//           ),
//         ],
//       ),
//     );
//   }

//   List<PieChartSectionData> showingSections() {
//     return List.generate(4, (i) {
//       final isTouched = i == touchedIndex;
//       final fontSize = isTouched ? 25.0 : 16.0;
//       final radius = isTouched ? 60.0 : 50.0;
//       const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

//       final items = ['item 1', 'item 2', 'item 3', 'item4'];
//       final colors = [
//         AppColors.contentColorBlue,
//         AppColors.contentColorYellow,
//         AppColors.contentColorPurple,
//         AppColors.contentColorGreen,
//       ];

//       return PieChartSectionData(
//         color: colors[i],
//         value: operationPercentages[items[i]],
//         title: '${operationPercentages[items[i]]?.toStringAsFixed(1) ?? 0}%',
//         radius: radius,
//         titleStyle: TextStyle(
//           fontSize: fontSize,
//           fontWeight: FontWeight.bold,
//           color: AppColors.mainTextColor1,
//           shadows: shadows,
//         ),
//       );
//     });
//   }
// }
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/home/widget/indicator.dart';
import 'package:dental_app/features/patien_details/model/model_operations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;
  List<OperationModel> operations = []; // List to hold operation data

  @override
  void initState() {
    super.initState();
    // Fetch operations from Firestore or your data source
    fetchOperations();
  }

  void fetchOperations() {
    // Simulated data - replace with Firestore or data fetching logic
    List<Map<String, dynamic>> dataFromFirestore = [
      {
        'name': 'Operation 1',
        'price': 500,
        'costPrice': 300,
        'priceGain': 200,
        'numOfTime': 10,
      },
      {
        'name': 'Operation 2',
        'price': 800,
        'costPrice': 400,
        'priceGain': 400,
        'numOfTime': 15,
      },
      {
        'name': 'Operation 3',
        'price': 600,
        'costPrice': 350,
        'priceGain': 250,
        'numOfTime': 8,
      },
      {
        'name': 'Operation 4',
        'price': 400,
        'costPrice': 250,
        'priceGain': 150,
        'numOfTime': 5,
      },
    ];

    // Convert fetched data to OperationModel objects
    operations = dataFromFirestore.map((data) {
      return OperationModel.fromMap(
          data, UniqueKey().toString()); // Replace with actual ID logic
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...operations.map((operation) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Indicator(
                      color: getColorForOperation(operation
                          .name), // Custom function to get color based on operation name
                      text: operation.name,
                      isSquare: true,
                    ),
                  )),
              SizedBox(
                height: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    double total =
        operations.fold(0, (sum, operation) => sum + operation.price);

    return operations.map((operation) {
      final isTouched = operations.indexOf(operation) == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      double percentage = (operation.price / total) * 100;

      return PieChartSectionData(
        color: getColorForOperation(operation
            .name), // Custom function to get color based on operation name
        value: operation.price,
        title: '${percentage.toStringAsFixed(1)}%', // Display percentage
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.mainTextColor1,
          shadows: shadows,
        ),
      );
    }).toList();
  }

  Color getColorForOperation(String operationName) {
    // Replace with your logic to assign colors based on operation name
    switch (operationName) {
      case 'Operation 1':
        return AppColors.contentColorBlue;
      case 'Operation 2':
        return AppColors.contentColorYellow;
      case 'Operation 3':
        return AppColors.contentColorPurple;
      case 'Operation 4':
        return AppColors.contentColorGreen;
      default:
        return Colors.grey; // Default color or fallback color
    }
  }
}
