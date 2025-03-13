
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/doctor_list_model.dart';
import '../models/medicine_model.dart';
import '../models/patient_list_model.dart';

class MedicinesController extends GetxController  {
  final RxList<MedicineModel> medicinesList = <MedicineModel>[].obs;
  var isLoading = false.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// get user list
  void getAllMedicinesList() {
    try {

      // Utils.showLoader();

      /// Use snapshots() to listen to real-time updates
      _firestore.collection('medicines_list').snapshots().listen((QuerySnapshot querySnapshot) {

        /// Map the Firestore documents to your UserModel
        List<MedicineModel> list = querySnapshot.docs.map((doc) {
          return MedicineModel.fromJson({
            ...doc.data() as Map<String, dynamic>,
            'id': doc.id.toString(),
          });
        }).toList();

        list.sort((a, b) => a.medicineId.compareTo(b.medicineId));


        medicinesList.clear();
        medicinesList.addAll(list);
        medicinesList.refresh();

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