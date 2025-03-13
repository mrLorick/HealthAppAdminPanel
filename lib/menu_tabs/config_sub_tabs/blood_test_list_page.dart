import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_admin_panel/utils/app_helpers.dart';

import '../../controllers/blood_test_controller.dart';
import '../../controllers/medicines_controller.dart';

class BloodTestListPage extends StatefulWidget {
  const BloodTestListPage({super.key});

  @override
  State<BloodTestListPage> createState() => _BloodTestListPageState();
}

class _BloodTestListPageState extends State<BloodTestListPage> {
  final BloodTestController controller = Get.put(BloodTestController());

  @override
  void initState() {
    controller.getAllBloodTestList();
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
                        : const Text("Add Blood Test", style: TextStyle(fontSize: 14,color: Colors.white)),
                  ),
                )
              ],
            ),
            yHeight(15),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double totalWidth = constraints.maxWidth;
                  double column1Width = totalWidth * 0.10; // 10% width
                  double column2Width = totalWidth * 0.20; // 20% width
                  double column3Width = totalWidth * 0.15; // 25% width
                  double column4Width = totalWidth * 0.30; // 15% width
                  double column5Width = totalWidth * 0.10; // 30% width
                  double column6Width = totalWidth * 0.15; // 30% width

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
                              _buildTableHeader("Sr No.", column1Width),
                              _buildTableHeader("ID", column2Width),
                              _buildTableHeader("Medicine Id", column3Width),
                              _buildTableHeader("Medicine Name", column4Width),
                              _buildTableHeader("Status", column5Width),
                              _buildTableHeader("Actions", column6Width),
                            ],
                          ),
                        ),

                        /// **Scrollable Table Body**
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Obx(() => Column(
                              children: controller.bloodTestList.asMap().entries.map((entry) {
                                int index = entry.key + 1;
                                var doctor = entry.value;
                                return Row(
                                  children: [
                                    _buildTableCell(index.toString(), column1Width),
                                    _buildTableCell(doctor.id, column2Width),
                                    _buildTableCell(doctor.bloodId.toString(), column3Width),
                                    _buildTableCell(doctor.name, column4Width),
                                    _buildTableCell(doctor.isActive ? "Active" : "Not Active", column5Width),
                                    _buildTableCell("View", column6Width, isButton: true),
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