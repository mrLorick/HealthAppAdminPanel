import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sidebar_controller.dart';


Widget menuItem(IconData icon, String title, int index, RxInt selectedPage) {
  final SidebarController controller = Get.put(SidebarController());

  return Obx(() => InkWell(
    onTap: () => selectedPage.value = index,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Prevents forcing full width
        children: [
          Icon(icon, color: Colors.white, size: 26),
          if (!controller.isCollapsed.value) const SizedBox(width: 10),
          if (!controller.isCollapsed.value)
            Flexible(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
        ],
      ),
    ),
  ));
}
