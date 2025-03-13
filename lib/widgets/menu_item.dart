import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sidebar_controller.dart';

final Map<String, int> subItemIndexes = {
  "Medicines": 4,
  "Blood Test": 5,
  "Symptoms": 6,
  "Diagnosis": 7,
};


Widget menuItem(
    IconData icon,
    String title,
    int index,
    RxInt selectedPage, {
      List<String>? subItems,
      Map<String, int>? subItemIndexes,
    }) {
  final SidebarController controller = Get.put(SidebarController());
  RxBool isHovered = false.obs;
  RxBool isExpanded = false.obs; // For expanding sub-items

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => MouseRegion(
          onEnter: (_) => isHovered.value = true,
          onExit: (_) => isHovered.value = false,
          child: GestureDetector(
            onTap: () {
              if (subItems != null) {
                isExpanded.value = !isExpanded.value;
              } else {
                selectedPage.value = index;
              }
            },
            child: Container(
              width: double.infinity, // Ensure full width
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: selectedPage.value == index || isHovered.value
                    ? Colors.blueGrey.shade700
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 20),
                  if (!controller.isCollapsed.value) const SizedBox(width: 10),
                  if (!controller.isCollapsed.value)
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                  if (subItems != null)
                    Icon(
                      isExpanded.value ? Icons.expand_less : Icons.expand_more,
                      color: Colors.white,
                    ),
                ],
              ),
            ),
          ),
        )),

        /// **Sub-items**
        if (subItems != null)
          Obx(() => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isExpanded.value ? subItems.length * 45.0 : 0,
            child: SingleChildScrollView(
              child: Column(
                children: subItems.map((subItem) {
                  return GestureDetector(
                    onTap: () {
                      if (subItemIndexes != null && subItemIndexes.containsKey(subItem)) {
                        selectedPage.value = subItemIndexes[subItem]!;
                      }
                      // **Remove isExpanded.value = false;**
                      // So it does not close when clicking sub-items
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 40, top: 8, bottom: 8),
                      decoration: BoxDecoration(
                        color: selectedPage.value == subItemIndexes?[subItem]
                            ? Colors.blueGrey.shade800
                            : Colors.transparent,
                      ),
                      child: Text(
                        subItem,
                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          )),

      ],
    ),
  );
}