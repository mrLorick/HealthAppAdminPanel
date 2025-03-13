
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/blood_test_model.dart';
import '../models/doctor_list_model.dart';
import '../models/medicine_model.dart';
import '../models/patient_list_model.dart';

class BloodTestController extends GetxController  {
  final RxList<BloodTestModel> bloodTestList = <BloodTestModel>[].obs;
  var isLoading = false.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// get user list
  void getAllBloodTestList() {
    try {

      // Utils.showLoader();

      /// Use snapshots() to listen to real-time updates
      _firestore.collection('blood_tests').snapshots().listen((QuerySnapshot querySnapshot) {

        /// Map the Firestore documents to your UserModel
        List<BloodTestModel> list = querySnapshot.docs.map((doc) {
          return BloodTestModel.fromJson({
            ...doc.data() as Map<String, dynamic>,
            'id': doc.id.toString(),
          });
        }).toList();

        list.sort((a, b) => a.bloodId.compareTo(b.bloodId));


        bloodTestList.clear();
        bloodTestList.addAll(list);
        bloodTestList.refresh();

        // Utils.hideLoader();
      });
    } catch (e) {
      // Utils.hideLoader();
      debugPrint("Error fetching users: $e");
    }
  }


  void addMedicine(){

  }
}