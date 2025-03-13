

class DoctorListModel {
  String id;
  int doctorId;
  String clinicAddress;
  String designation;
  String email;
  String experience;
  String fullName;
  String govId;
  String hospitalClinicName;
  String phoneNumber;
  String? profilePic;
  String medicalDegree;
  String receptionFees;
  bool isActive;
  bool isApproved;

  DoctorListModel({
    required this.id,
    required this.doctorId,
    required this.clinicAddress,
    required this.designation,
    required this.email,
    required this.experience,
    required this.fullName,
    required this.govId,
    required this.profilePic,
    required this.hospitalClinicName,
    required this.phoneNumber,
    required this.isActive,
    required this.isApproved,
    required this.medicalDegree,
    required this.receptionFees,
  });

  // Convert to JSON (if needed for Firebase)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "doctorId": doctorId,
      "clinic_address": clinicAddress,
      "designation": designation,
      "email": email,
      "experience": experience,
      "fullName": fullName,
      "gov_id": govId,
      "profile_pic": profilePic,
      "reception_fees": receptionFees,
      "hospital_clinic_name": hospitalClinicName,
      "isActive": isActive,
      "isApproved": isApproved,
      "phone_number": phoneNumber,
      "medical_degree": medicalDegree,
    };
  }

  // Create from JSON
  factory DoctorListModel.fromJson(Map<String, dynamic> json) {
    return DoctorListModel(
      id: json["id"],
      doctorId: json["doctorId"],
      clinicAddress: json["clinic_address"],
      designation: json["designation"],
      email: json["email"],
      experience: json["experience"],
      profilePic: json["profile_pic"],
      fullName: json["fullName"],
      receptionFees: json["reception_fees"],
      govId: json["gov_id"],
      hospitalClinicName: json["hospital_clinic_name"],
      isActive: json["isActive"],
      isApproved: json["isApproved"],
      phoneNumber: json["phone_number"],
      medicalDegree: json["medical_degree"],
    );
  }
}