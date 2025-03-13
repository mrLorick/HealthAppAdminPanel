
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/doctor_list_model.dart';

class DoctorController extends GetxController  {
  final RxList<DoctorListModel> doctorList = <DoctorListModel>[].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// get user list
  void getAllDoctorList() {
    try {

      // Utils.showLoader();

      /// Use snapshots() to listen to real-time updates
      _firestore.collection('doctors_list').snapshots().listen((QuerySnapshot querySnapshot) {

        /// Map the Firestore documents to your UserModel
        List<DoctorListModel> list = querySnapshot.docs.map((doc) {
          return DoctorListModel.fromJson({
            ...doc.data() as Map<String, dynamic>,
            'id': doc.id,
          });
        }).toList();

        doctorList.clear();
        doctorList.addAll(list);
        doctorList.refresh();

        // Utils.hideLoader();
      });
    } catch (e) {
      // Utils.hideLoader();
      debugPrint("Error fetching users: $e");
    }
  }

}