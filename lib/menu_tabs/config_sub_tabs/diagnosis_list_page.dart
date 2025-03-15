import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_admin_panel/utils/app_helpers.dart';
import 'package:health_app_admin_panel/utils/app_utils.dart';

import '../../controllers/diagnosis_controller.dart';

class DiagnosisListPage extends StatefulWidget {
  const DiagnosisListPage({super.key});

  @override
  State<DiagnosisListPage> createState() => _DiagnosisListPageState();
}

class _DiagnosisListPageState extends State<DiagnosisListPage> {
  final DiagnosisController controller = Get.put(DiagnosisController());

  @override
  void initState() {
    controller.getAllDisgnosisList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search Diagnosis...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                xWidth(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value ? null : controller.addMedicine,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF811f1a),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Add Diagnosis", style: TextStyle(fontSize: 14,color: Colors.white)),
                  ),
                )
              ],
            ),
            yHeight(15),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double totalWidth = constraints.maxWidth;
                  Map<String, double> columnWidths = Utils.tableColumnWidths(totalWidth);

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /// **Fixed Header Row**
                        Container(
                          color: Colors.blueGrey.shade200,
                          height: 50,
                          child: Row(
                            children: [
                              _buildTableHeader("Sr No.", columnWidths["column10"]!),
                              // _buildTableHeader("ID", column2Width),
                              _buildTableHeader("Diagnosis Id", columnWidths["column10"]!),
                              _buildTableHeader("Diagnosis Name", columnWidths["column40"]!),
                              _buildTableHeader("Status", columnWidths["column20"]!),
                              _buildTableHeader("Actions", columnWidths["column10"]!),
                              _buildTableHeader("Delete", columnWidths["column10"]!),
                            ],
                          ),
                        ),

                        /// **Scrollable Table Body**
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Obx(() => Column(
                              children: controller.diagnosisList.asMap().entries.map((entry) {
                                int index = entry.key + 1;
                                var doctor = entry.value;
                                return Row(
                                  children: [
                                    _buildTableCell(index.toString(), columnWidths["column10"]!),
                                    // _buildTableCell(doctor.id, column2Width),
                                    _buildTableCell(doctor.diagnosisId.toString(), columnWidths["column10"]!),
                                    _buildTableCell(doctor.name, columnWidths["column40"]!),
                                    _buildTableCell(doctor.isActive ? "Active" : "Not Active", columnWidths["column20"]!),
                                    _buildTableCell("Edit", columnWidths["column10"]!, isButton: true),
                                    _buildTableCell("Delete", columnWidths["column10"]!, isButton: true),
                                  ],
                                );
                              }).toList(),
                            ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// **Reusable Table Header Widget**
  Widget _buildTableHeader(String text, double width) {
    return Container(
      width: width,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  /// **Reusable Table Cell Widget**
  Widget _buildTableCell(String text, double width, {bool isButton = false}) {
    return Container(
      width: width,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: isButton
          ? TextButton(
        onPressed: () {},
        child:  Text(text.toString()
          , style: const TextStyle(color: Colors.blue),textAlign: TextAlign.start,),
      )
          : Text(text),
    );
  }
}