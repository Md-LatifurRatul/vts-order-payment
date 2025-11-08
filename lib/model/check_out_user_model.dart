import 'dart:convert';

class CheckOutUserModel {
  final String fullName;
  final String mobile;
  final String email;
  final String vehicleModel;
  final String vtsDeliveryAddress;
  final String vtsInstallationAddress;

  CheckOutUserModel({
    required this.fullName,
    required this.mobile,
    required this.email,
    required this.vehicleModel,
    required this.vtsDeliveryAddress,
    required this.vtsInstallationAddress,
  });

  // Convert to Map (for SharedPreferences)
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'mobile': mobile,
      'email': email,
      'vehicleModel': vehicleModel,
      'vtsDeliveryAddress': vtsDeliveryAddress,
      'vtsInstallationAddress': vtsInstallationAddress,
    };
  }

  factory CheckOutUserModel.fromMap(Map<String, dynamic> map) {
    return CheckOutUserModel(
      fullName: map['fullName'] ?? '',
      mobile: map['mobile'] ?? '',
      email: map['email'] ?? '',
      vehicleModel: map['vehicleModel'] ?? '',
      vtsDeliveryAddress: map['vtsDeliveryAddress'] ?? '',
      vtsInstallationAddress: map['vtsInstallationAddress'] ?? '',
    );
  }

  // JSON for api
  String toJson() => json.encode(toMap());
  factory CheckOutUserModel.fromJson(String source) =>
      CheckOutUserModel.fromMap(json.decode(source));
}
