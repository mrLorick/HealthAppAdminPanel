


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../locale_storage/shared_preference_helper.dart';
import '../pages/admin_main_page.dart';
import '../utils/app_utils.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late SharedPreferenceHelper storage;


  @override
  void onInit() {
    storage = SharedPreferenceHelper();
    super.onInit();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  void login() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // Simulate API Call
    isLoading.value = false;

    FocusManager.instance.primaryFocus?.unfocus();
    adminLogin(
        email: emailController.text,
        pass: passwordController.text,
        fcmToken: ""
    );

  }


  ///login validation
  bool loginValidation({
    required String email,required String pass
  }) {
    final trimmedEmail = email.trim();
    final trimmedPassword = pass.trim();

    if (trimmedEmail.isEmpty) {
      Get.snackbar("Attention", "Mobile Email Id cannot be empty.");
      return false;
    } else if (trimmedPassword.isEmpty) {
      Get.snackbar("Attention", "Password cannot be empty.");
      return false;
    } else if (trimmedPassword.length < 6) {
      Get.snackbar("Attention", "Password must be at least 6 characters long.");
      return false;
    } else {
      return true;
    }
  }


  Future<void> adminLogin({
    required String email,required String pass,
    required String fcmToken,
  }) async {
    final isValid = loginValidation(email: email, pass: pass);

    if(!isValid){
      return;
    }

    if( !(await Utils.hasNetwork())){
      Utils.toast(msg: "Internet connection not available",isError: true);
      return;
    }

    // Utils.showLoader();

    try{

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      /// If successful, update state
      if (userCredential.user != null) {

        DocumentSnapshot userSnapshot = await _firestore.collection('patient').doc(userCredential.user!.uid).get();

        /// Check if the user document exists
        if (userSnapshot.exists) {
          Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;


          ///Update FCM Token
          Map<String, dynamic> updatedData = {};
          updatedData['fcm'] = fcmToken;

          await _firestore.collection('patient').doc(userCredential.user!.uid).update(updatedData);

          /// Access user details from Firestorm
          String userName = userData['name'] ?? 'NA';
          String userRoll = userData['role'] ?? 'NA';
          bool userStatus = userData['status'] ?? false;

          storage.saveUserToken(userSnapshot.id);
          storage.saveUserName(userName);
          storage.saveIsAdminRole(true);

          //
          // if(userRoll == "User"){
          //   storage.saveIsAdminRole(false);
          //
          //   if(userStatus){
          //     storage.saveUserType(1);
          //     Get.to(() => const PatientDashboard());
          //   }else{
          //     Get.to(() => LoginScreen());
          //   }
          // }else if(userRoll == "Admin"){
          //   storage.saveIsAdminRole(true);
          //   storage.saveUserType(2);
          //   Get.to(() => const WelcomeScreen());
          // }

          // Utils.hideLoader();

          Get.to(() => AdminPanel());

          Get.snackbar("Success", "Login successful!", snackPosition: SnackPosition.TOP);

        }else{
          Utils.toast(msg: "Doctor");
        }
      }
    }catch(_){
      // Utils.hideLoader();
    }
  }
}