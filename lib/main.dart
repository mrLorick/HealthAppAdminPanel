import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app_admin_panel/pages/admin_main_page.dart';
import 'package:health_app_admin_panel/pages/login_page.dart';
import 'package:health_app_admin_panel/services/firebase_options.dart';
import 'locale_storage/shared_preference_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferenceHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferenceHelper storage;

  @override
  void initState() {
    storage = SharedPreferenceHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: storage.getIsUserAdminRole() == true ? AdminPanel() : AdminLoginPage(),
    );
  }
}




