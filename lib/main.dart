import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_admin_pannel/widgets/menu_item.dart';

import 'controllers/sidebar_controller.dart';
import 'menu_tabs/dashboard_page.dart';
import 'menu_tabs/doctor_list_page.dart';
import 'menu_tabs/patient_list_page.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminPanel(),
    );
  }
}

class AdminPanel extends StatelessWidget {
  final SidebarController controller = Get.put(SidebarController());
  final RxInt selectedPage = 0.obs;

  final List<Widget> pages = [
    DashboardScreen(),
    PatientListScreen(),
    DoctorListScreen(),
  ];


  final List<String> pageTitles = [
    "Dashboard",
    "Patient List",
    "Doctor List",
  ];

  
  AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          /// Sidebar
          Obx(() => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: controller.isCollapsed.value ? 60 : 250,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade900,
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
            ),
            child: Column(
              children: [
                /// Sidebar Header
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      if (!controller.isCollapsed.value)
                        const Expanded(
                          child: Text(
                            "Admin Panel",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () => controller.toggleSidebar(),
                      ),
                    ],
                  ),
                ),
                // Sidebar Menu Items
                Expanded(
                  child: ListView(
                    children: [
                      menuItem(Icons.dashboard, "Dashboard", 0, selectedPage),
                      menuItem(Icons.person, "Patients", 1, selectedPage),
                      menuItem(Icons.medical_services, "Doctors", 2, selectedPage),
                    ],
                  ),
                ),
              ],
            ),
          )),
          /// Main Content Area
          Expanded(
            child: Column(
              children: [
                /// Fixed Header with Dynamic Title
                Obx(() => Container(
                  height: 60, // Fixed height
                  color: Colors.blueGrey.shade700,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pageTitles[selectedPage.value], // Dynamically change title
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      Container(
                        height: 40,
                        width: 40,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                          child: Image.asset("assets/images/doctor_place_holder_male.jpeg"),
                        ),
                      ),
                    ],
                  ),
                )),

                /// Page Content
                Expanded(
                  child: Obx(() => pages[selectedPage.value]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}




