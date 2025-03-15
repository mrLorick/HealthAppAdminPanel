
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/blood_test_model.dart';
import '../models/doctor_list_model.dart';
import '../models/medicine_model.dart';
import '../models/patient_list_model.dart';
import '../models/symptoms_model.dart';

class SymptomsController extends GetxController  {
  final RxList<SymptomsModel> symptomsList = <SymptomsModel>[].obs;
  var isLoading = false.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// get user list
  void getAllSymptomsTestList() {
    try {

      // Utils.showLoader();

      /// Use snapshots() to listen to real-time updates
      _firestore.collection('symptoms_list').snapshots().listen((QuerySnapshot querySnapshot) {

        /// Map the Firestore documents to your UserModel
        List<SymptomsModel> list = querySnapshot.docs.map((doc) {
          return SymptomsModel.fromJson({
            ...doc.data() as Map<String, dynamic>,
            'id': doc.id.toString(),
          });
        }).toList();

        list.sort((a, b) => a.symptomsId.compareTo(b.symptomsId));


        symptomsList.clear();
        symptomsList.addAll(list);
        symptomsList.refresh();

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