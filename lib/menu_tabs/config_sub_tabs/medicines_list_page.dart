import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_admin_panel/utils/app_helpers.dart';

import '../../controllers/medicines_controller.dart';

class MedicinesListPage extends StatefulWidget {
  const MedicinesListPage({super.key});

  @override
  State<MedicinesListPage> createState() => _MedicinesListPageState();
}

class _MedicinesListPageState extends State<MedicinesListPage> {
  final MedicinesController controller = Get.put(MedicinesController());

  @override
  void initState() {
    controller.getAllMedicinesList();
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
                      hintText: "Search Medicine...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                xWidth(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value ? null : controller.addMedicine,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF811f1a),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Add Medicine", style: TextStyle(fontSize: 14,color: Colors.white)),
                  ),
                )
              ],
            ),
            yHeight(15),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double totalWidth = constraints
                      .maxWidth; // Get available width
                  double column1Width = totalWidth * 0.20; // 10% width
                  double column2Width = totalWidth * 0.20; // 20% width
                  double column3Width = totalWidth * 0.25; // 25% width
                  double column4Width = totalWidth * 0.15; // 15% width
                  double column5Width = totalWidth * 0.20; // 30% width

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
                              _buildTableHeader("ID", column1Width),
                              _buildTableHeader("Medicine Id", column2Width),
                              _buildTableHeader("Medicine Name", column3Width),
                              _buildTableHeader("Status", column4Width),
                              _buildTableHeader("Actions", column5Width),
                            ],
                          ),
                        ),

                        /// **Scrollable Table Body**
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Obx(() => Column(
                                    children: controller.medicinesList.map((doctor) {
                                      return Row(
                                        children: [
                                          _buildTableCell(doctor.id, column1Width),
                                          _buildTableCell(doctor.medicineId.toString(), column2Width),
                                          _buildTableCell(doctor.name, column3Width),
                                          _buildTableCell(doctor.isActive ? "Active" : "Not Active", column4Width),
                                          _buildTableCell("View", column5Width, isButton: true),
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
        child: const Text("View", style: TextStyle(color: Colors.blue),textAlign: TextAlign.start,),
      )
          : Text(text),
    );
  }
}