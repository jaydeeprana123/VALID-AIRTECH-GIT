class LoginRequest {
  String? userName;
  String? password;
  String? deviceId;
  String? deviceType;

  LoginRequest({this.userName, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    password = json['password'];
    deviceId = json["device_id"];
    deviceType = json["device_type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = userName;
    data['password'] = password;
    data["device_id"] = deviceId;
    data["device_type"] = deviceType;
    return data;
  }
}

