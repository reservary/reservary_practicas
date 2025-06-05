class UserData {
  final String id;
  final String required;
  final String name;
  final String value;
  final String? dataType;
  final String? countryCode;
  final String? dialCode;
  final String? type;

  UserData({
    required this.id,
    required this.required,
    required this.name,
    required this.value,
    this.dataType,
    this.countryCode,
    this.dialCode,
    this.type,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      required: json['required'],
      name: json['name'],
      value: json['value'],
      dataType: json['dataType'],
      countryCode: json['countryCode'],
      type: json['type'],
      dialCode: json['dialCode'],
    );
  }
}