import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_admin_panel/utils/app_helpers.dart';

import '../controllers/patient_controller.dart';

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

            /// 🏥 Doctor List Table
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: constraints.maxWidth, // 👈 Full-width dynamically
                      child: Obx(
                            () => DataTable(
                          columnSpacing: 20, // Adjust spacing for better layout
                          headingRowColor: MaterialStateProperty.all(Colors.blueGrey.shade200),
                          columns: const [
                            DataColumn(label: Text("Sr No.",style: TextStyle(fontWeight: FontWeight.bold),)),
                            DataColumn(label: Text("ID",style: TextStyle(fontWeight: FontWeight.bold),)),
                            DataColumn(label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold),)),
                            DataColumn(label: Text("Status",style: TextStyle(fontWeight: FontWeight.bold),)),
                            DataColumn(label: Text("Weight",style: TextStyle(fontWeight: FontWeight.bold),)),
                            DataColumn(label: Text("Phone",style: TextStyle(fontWeight: FontWeight.bold),)),
                            DataColumn(label: Text("Email",style: TextStyle(fontWeight: FontWeight.bold),)),
                            DataColumn(label: Text("Role",style: TextStyle(fontWeight: FontWeight.bold),)),
                            DataColumn(label: Text("Actions",style: TextStyle(fontWeight: FontWeight.bold),)),
                          ], rows: controller.patientList.asMap().entries.map((entry) {
                          int index = entry.key + 1;
                          var doctor = entry.value;
                          return DataRow(cells: [
                            DataCell(Text(index.toString())),
                            DataCell(Text(doctor.id)),
                            DataCell(Text("${doctor.firstName} ${doctor.lastName}" )),
                            DataCell(Text(doctor.isActive ? "Active" : "Not Active")),
                            DataCell(Text(doctor.weight)),
                            DataCell(Text(doctor.phoneNumber)),
                            DataCell(Text(doctor.email)),
                            DataCell(Text(doctor.role.toString())),
                            DataCell(Row(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text("View", style: TextStyle(color: Colors.blue)),
                                ),
                              ],
                            )),
                          ]);
                        }).toList(),
                        ),
                      ),
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
}
