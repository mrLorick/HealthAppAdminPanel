

class DiagnosisModel {
  final String id;
  final int diagnosisId;
  final bool isEnabled;
  final String name;
  bool isSelected = false;
  bool isActive = true;

  DiagnosisModel({
    required this.id,
    required this.diagnosisId,
    required this.isEnabled,
    required this.name,
    required this.isSelected,
  });

  Map<String, dynamic> toJson() {
    return {
      'diagnosisId': diagnosisId,
      'isEnabled': isEnabled,
      'isSelected': isSelected,
      'name': name,
    };
  }

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisModel(
      id: json['id'] ?? -1,
      diagnosisId: json['diagnosisId'] ?? -1,
      isEnabled: json['isEnabled'] ?? false,
      isSelected: json['isSelected'] ?? false,
      name: json['name'] ?? '',
    );
  }
}