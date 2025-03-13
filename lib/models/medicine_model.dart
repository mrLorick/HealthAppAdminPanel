
class MedicineModel {
  String id;
  int medicineId;
  String name;
  int dose;
  int duration;
  bool isSelected;
  bool isActive;

  MedicineModel({
    required this.id,
    required this.medicineId,
    required this.name, required this.dose, required this.duration,
    required this.isSelected,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicineId': medicineId,
      'dose': dose,
      'duration': duration,
      'name': name,
      'isSelected': isSelected,
    };
  }

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['id'] ?? -1,
      medicineId: json['medicineId'] ?? -1,
      name: json['name'] ?? "",
      dose: json['dose'] ?? 0,
      duration: json['duration'] ?? 0,
      isSelected: json['isSelected'] ?? false,
    );
  }
}
