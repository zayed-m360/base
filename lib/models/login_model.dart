// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    bool? success;
    String? message;
    LoginData? data;
    String? token;

    LoginModel({
        this.success,
        this.message,
        this.data,
        this.token,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "token": token,
    };
}

class LoginData {
    int? id;
    String? name;
    int? agencyId;
    String? email;
    String? mobileNumber;
    int? status;
    int? isVerified;

    LoginData({
        this.id,
        this.name,
        this.agencyId,
        this.email,
        this.mobileNumber,
        this.status,
        this.isVerified,
    });

    factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        id: json["id"],
        name: json["name"],
        agencyId: json["agency_id"],
        email: json["email"],
        mobileNumber: json["mobile_number"],
        status: json["status"],
        isVerified: json["is_verified"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "agency_id": agencyId,
        "email": email,
        "mobile_number": mobileNumber,
        "status": status,
        "is_verified": isVerified,
    };
}
