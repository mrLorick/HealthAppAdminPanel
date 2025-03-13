
import 'package:get/get.dart';

class SidebarController extends GetxController {
  var isCollapsed = false.obs;
  void toggleSidebar() => isCollapsed.value = !isCollapsed.value;
}