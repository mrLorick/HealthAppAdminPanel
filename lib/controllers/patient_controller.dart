
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/doctor_list_model.dart';
import '../models/patient_list_model.dart';

class PatientController extends GetxController  {
  final RxList<PatientListModel> patientList = <PatientListModel>[].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// get user list
  void getAllPatientList() {
    try {

      // Utils.showLoader();

      /// Use snapshots() to listen to real-time updates
      _firestore.collection('patient').snapshots().listen((QuerySnapshot querySnapshot) {

        /// Map the Firestore documents to your UserModel
        List<PatientListModel> list = querySnapshot.docs.map((doc) {
          return PatientListModel.fromJson({
            ...doc.data() as Map<String, dynamic>,
            'id': doc.id.toString(),
          });
        }).toList();

        // list.sort((a, b) => a.medicineId.compareTo(b.medicineId));

        patientList.clear();
        patientList.addAll(list);
        patientList.refresh();

        // Utils.hideLoader();
      });
    } catch (e) {
      // Utils.hideLoader();
      debugPrint("Error fetching users: $e");
    }
  }

}