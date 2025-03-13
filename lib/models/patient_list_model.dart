


class PatientListModel {
  String id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;
  String role;
  String allergy;
  String height;
  String weight;
  bool isActive;
  bool status;
  String fcm;
  // DateTime createdAt;
  // DateTime updatedAt;

  PatientListModel({
    this.id = "",
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.role,
    required this.allergy,
    required this.height,
    required this.weight,
    required this.isActive,
    required this.status,
    required this.fcm,
    // required this.createdAt,
    // required this.updatedAt,
  });

  // Convert to JSON (useful for Firebase or API calls)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "role": role,
      "allergy": allergy,
      "height": height,
      "weight": weight,
      "isActive": isActive,
      "status": status,
      "fcm": fcm,
      // "created_at": createdAt.toIso8601String(),
      // "updated_at": updatedAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory PatientListModel.fromJson(Map<String, dynamic> json) {
    return PatientListModel(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      password: json["password"],
      role: json["role"],
      allergy: json["allergy"],
      height: json["height"],
      weight: json["weight"],
      isActive: json["isActive"] ?? false,
      status: json["status"] ?? false,
      fcm: json["fcm"] ?? "",
      // createdAt: DateTime.parse(json["created_at"]),
      // updatedAt: DateTime.parse(json["updated_at"]),
    );
  }
}
