

class BloodTestModel {
  final String id;
  final int bloodId;
  final bool isEnabled;
  final String name;
  bool isSelected = false;
  bool isActive = true;

  BloodTestModel({
    required this.id,
    required this.bloodId,
    required this.isEnabled,
    required this.name,
    required this.isSelected,
  });

  Map<String, dynamic> toJson() {
    return {
      'bloodId': bloodId,
      'isEnabled': isEnabled,
      'isSelected': isSelected,
      'name': name,
    };
  }

  factory BloodTestModel.fromJson(Map<String, dynamic> json) {
    return BloodTestModel(
      id: json['id'] ?? -1,
      bloodId: json['bloodId'] ?? -1,
      isEnabled: json['isEnabled'] ?? false,
      isSelected: json['isSelected'] ?? false,
      name: json['name'] ?? '',
    );
  }
}