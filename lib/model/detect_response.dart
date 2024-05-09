class DetectResponse {
  DetectResponse({
    required this.message,
    required this.name,
    required this.age,
    required this.gender,
  });

  late final String message;
  late final String name;
  late final double age;
  late final String gender;

  DetectResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? ''; // Handle nullable message
    name = json['name'] ?? ''; // Handle nullable name
    age = json['age']?.toDouble() ?? 0.0; // Handle nullable age
    gender = json['gender'] ?? ''; // Handle nullable gender
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['name'] = name;
    data['age'] = age;
    data['gender'] = gender;
    return data;
  }
}
