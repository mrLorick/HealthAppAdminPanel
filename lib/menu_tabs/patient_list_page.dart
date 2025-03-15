import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_admin_panel/utils/app_helpers.dart';

import '../controllers/patient_controller.dart';
import '../utils/app_utils.dart';

class PatientListPage extends StatefulWidget {
  const PatientListPage({super.key});

  @override
  State<PatientListPage> createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  final PatientController controller = Get.put(PatientController());

  @override
  void initState() {
    controller.getAllPatientList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// 🔍 Search Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3, // Dynamic width
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search Patient...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
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
                              _buildTableHeader("Sr No.", columnWidths["column8"]!),
                              // _buildTableHeader("ID", column2Width),
                              _buildTableHeader("Patient Id", columnWidths["column8"]!),
                              _buildTableHeader("Patient Name", columnWidths["column20"]!),
                              _buildTableHeader("Phone Number", columnWidths["column10"]!),
                              _buildTableHeader("Email", columnWidths["column15"]!),
                              _buildTableHeader("Height", columnWidths["column8"]!),
                              _buildTableHeader("Weight", columnWidths["column8"]!),
                              _buildTableHeader("Status", columnWidths["column8"]!),
                              _buildTableHeader("Actions", columnWidths["column8"]!),
                              _buildTableHeader("Delete", columnWidths["column8"]!),
                            ],
                          ),
                        ),

                        /// **Scrollable Table Body**
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Obx(() => Column(
                              children: controller.patientList.asMap().entries.map((entry) {
                                int index = entry.key + 1;
                                var doctor = entry.value;
                                return Row(
                                  children: [
                                    _buildTableCell(index.toString(), columnWidths["column8"]!),
                                    // _buildTableCell(doctor.id, column2Width),
                                    _buildTableCell(index.toString(), columnWidths["column8"]!),
                                    _buildTableCell("${doctor.firstName} ${doctor.lastName}", columnWidths["column20"]!),
                                    _buildTableCell(doctor.phoneNumber, columnWidths["column10"]!),
                                    _buildTableCell(doctor.email, columnWidths["column15"]!),
                                    _buildTableCell(doctor.height, columnWidths["column8"]!),
                                    _buildTableCell(doctor.weight, columnWidths["column8"]!),
                                    _buildTableCell(doctor.isActive ? "Active" : "Not Active", columnWidths["column8"]!),
                                    _buildTableCell("Edit", columnWidths["column8"]!, isButton: true),
                                    _buildTableCell("Delete", columnWidths["column8"]!, isButton: true),
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
