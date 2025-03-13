import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_admin_panel/utils/app_helpers.dart';

import '../controllers/sidebar_controller.dart';
import '../menu_tabs/config_sub_tabs/blood_test_list_page.dart';
import '../menu_tabs/config_sub_tabs/medicines_list_page.dart';
import '../menu_tabs/dashboard_page.dart';
import '../menu_tabs/doctor_list_page.dart';
import '../menu_tabs/patient_list_page.dart';
import '../widgets/menu_item.dart';


class AdminPanel extends StatelessWidget {
  final SidebarController controller = Get.put(SidebarController());
  final RxInt selectedPage = 0.obs;

  final List<Widget> pages = [
    const DashboardScreen(),   // 0
    const PatientListPage(),   // 1
    const DoctorListPage(),    // 2
    const DoctorListPage(),        // 30



    const MedicinesListPage(),
    BloodTestListPage(),     // 31
    DoctorListPage(),      // 32
    DoctorListPage(),
    // 33
    DoctorListPage(),     // 33
  ];

  /// **Page Titles**
  final List<String> pageTitles = [
    "Dashboard",
    "Patient List",
    "Doctor List",
    "Config",
    "Medicines",
    "Blood Test",
    "Symptoms",
    "Diagnosis",

    "Settings",
  ];


  AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [

          /// Sidebar
          Obx(() =>
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: controller.isCollapsed.value ? 60 : 250,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade900,
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 5)
                  ],
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
                          menuItem(Icons.dashboard_customize_outlined, "Dashboard", 0, selectedPage),
                          menuItem(Icons.person_outline_outlined, "Patients", 1, selectedPage),
                          menuItem(Icons.person_pin_outlined, "Doctors", 2, selectedPage),
                          menuItem(Icons.file_copy_outlined, "Config", 3, selectedPage,subItems: ["Medicines","Blood Test","Symptoms","Diagnosis"],subItemIndexes: subItemIndexes),
                        ],
                      ),
                    ),
                    yHeight(100),
                    menuItem(Icons.settings_outlined, "Setting", 8, selectedPage),
                    menuLogoutItem(Icons.logout_outlined, "Logout", 5, 100.obs),
                  ],
                ),
              )),

          /// Main Content Area
          Expanded(
            child: Column(
              children: [

                /// Fixed Header with Dynamic Title
                Obx(() =>
                    Container(
                      height: 60,
                      // Fixed height
                      color: Colors.blueGrey.shade700,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pageTitles[selectedPage.value],
                            // Dynamically change title
                            style: const TextStyle(color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),

                          SizedBox(
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
                  child: Obx(() {
                    // Ensure safe index selection
                    int pageIndex = selectedPage.value;
                    return pageIndex >= 0 && pageIndex < pages.length
                        ? pages[pageIndex]
                        : const Center(child: Text("Page Not Found", style: TextStyle(color: Colors.white)));
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}