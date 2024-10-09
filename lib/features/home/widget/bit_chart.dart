import 'package:dental_app/features/home/controller/operation_controller.dart';
import 'package:dental_app/features/home/widget/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class PieChartOperation extends StatelessWidget {
  PieChartOperation({Key? key}) : super(key: key);

  final OperationController operationController =
      Get.put(OperationController());

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var isMobile = screenSize.width < 600;

    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: Obx(() {
              if (operationController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              return AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          operationController.touchedIndex.value = -1;
                          return;
                        }
                        operationController.touchedIndex.value =
                            pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: operationController.showingSections(),
                  ),
                ),
              );
            }),
          ),
          Column(
            mainAxisAlignment:
                isMobile ? MainAxisAlignment.end : MainAxisAlignment.center,
            crossAxisAlignment:
                isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: <Widget>[
              ...operationController.operations.map((operation) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Indicator(
                      color: operationController
                          .getColorForOperation(operation.name!),
                      text: operation.name!,
                      isSquare: true,
                    ),
                  )),
              const SizedBox(
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
}
