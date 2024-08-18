// To parse this JSON data, do
//
//     final sendOtpModel = sendOtpModelFromJson(jsonString);

import 'dart:convert';

SendOtpModel sendOtpModelFromJson(String str) => SendOtpModel.fromJson(json.decode(str));

String sendOtpModelToJson(SendOtpModel data) => json.encode(data.toJson());

class SendOtpModel {
    bool? success;
    String? message;
    SendOtpData? data;

    SendOtpModel({
        this.success,
        this.message,
        this.data,
    });

    factory SendOtpModel.fromJson(Map<String, dynamic> json) => SendOtpModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : SendOtpData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class SendOtpData {
    String? email;

    SendOtpData({
        this.email,
    });

    factory SendOtpData.fromJson(Map<String, dynamic> json) => SendOtpData(
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
    };
}
