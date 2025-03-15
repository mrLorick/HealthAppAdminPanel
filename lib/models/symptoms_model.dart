

class SymptomsModel {
  final String id;
  final int symptomsId;
  final bool isEnabled;
  final String name;
  bool isSelected = false;
  bool isActive = true;

  SymptomsModel({
    required this.id,
    required this.symptomsId,
    required this.isEnabled,
    required this.name,
    required this.isSelected,
  });

  Map<String, dynamic> toJson() {
    return {
      'symptomsId': symptomsId,
      'isEnabled': isEnabled,
      'isSelected': isSelected,
      'symptomsName': name,
    };
  }

  factory SymptomsModel.fromJson(Map<String, dynamic> json) {
    return SymptomsModel(
      id: json['id'] ?? -1,
      symptomsId: json['symptomsId'] ?? -1,
      isEnabled: json['isEnabled'] ?? false,
      isSelected: json['isSelected'] ?? false,
      name: json['symptomsName'] ?? '',
    );
  }
}