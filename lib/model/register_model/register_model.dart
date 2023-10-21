import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
    final String? statusCode;
    final String? message;
    final int? userId;

    Register({
        this.statusCode,
        this.message,
        this.userId,
    });

    factory Register.fromJson(Map<String, dynamic> json) => Register(
        statusCode: json["status_code"],
        message: json["message"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "user_id": userId,
    };
}
