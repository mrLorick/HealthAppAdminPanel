import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_admin_pannel/controllers/doctor_controller.dart';
import 'package:health_app_admin_pannel/utils/app_helpers.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({super.key});

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  final DoctorController controller = Get.put(DoctorController());

  @override
  void initState() {
    controller.getAllDoctorList();
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
                      hintText: "Search Doctors...",
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
                            DataColumn(label: Text("ID",style: TextStyle(fontWeight: FontWeight.bold),)),
                            DataColumn(label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold),)),
                            DataColumn(label: Text("Status",style: TextStyle(fontWeight: FontWeight.bold),)),
                            DataColumn(label: Text("Clinic",style: TextStyle(fontWeight: FontWeight.bold),)),
                            DataColumn(label: Text("Phone",style: TextStyle(fontWeight: FontWeight.bold),)),
                            DataColumn(label: Text("Email",style: TextStyle(fontWeight: FontWeight.bold),)),
                            DataColumn(label: Text("Approved",style: TextStyle(fontWeight: FontWeight.bold),)),
                            DataColumn(label: Text("Actions",style: TextStyle(fontWeight: FontWeight.bold),)),
                          ],
                          rows: controller.doctorList.map((doctor) {
                            return DataRow(cells: [
                              DataCell(Text(doctor.id)),
                              DataCell(Text(doctor.fullName)),
                              DataCell(Text(doctor.isActive ? "Active" : "Not Active")),
                              DataCell(Text(doctor.hospitalClinicName)),
                              DataCell(Text(doctor.phoneNumber)),
                              DataCell(Text(doctor.email)),
                              DataCell(Text(doctor.isApproved ? "Yes" : "No")),
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
