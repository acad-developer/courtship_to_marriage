// To parse this JSON data, do
//
//     final emailVerify = emailVerifyFromJson(jsonString);

import 'dart:convert';

EmailVerify emailVerifyFromJson(String str) => EmailVerify.fromJson(json.decode(str));

String emailVerifyToJson(EmailVerify data) => json.encode(data.toJson());

class EmailVerify {
    final String? email;
    final bool? validSyntax;
    final bool? validTld;
    final bool? disposable;
    final bool? roleAccount;
    final bool? freemail;
    final bool? rcptExists;
    final int? rcptStatusCode;
    final int? score;
    final String? timeTaken;

    EmailVerify({
        this.email,
        this.validSyntax,
        this.validTld,
        this.disposable,
        this.roleAccount,
        this.freemail,
        this.rcptExists,
        this.rcptStatusCode,
        this.score,
        this.timeTaken,
    });

    factory EmailVerify.fromJson(Map<String, dynamic> json) => EmailVerify(
        email: json["email"],
        validSyntax: json["valid_syntax"],
        validTld: json["valid_tld"],
        disposable: json["disposable"],
        roleAccount: json["role_account"],
        freemail: json["freemail"],
        rcptExists: json["rcpt_exists"],
        rcptStatusCode: json["rcpt_status_code"],
        score: json["score"],
        timeTaken: json["time_taken"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "valid_syntax": validSyntax,
        "valid_tld": validTld,
        "disposable": disposable,
        "role_account": roleAccount,
        "freemail": freemail,
        "rcpt_exists": rcptExists,
        "rcpt_status_code": rcptStatusCode,
        "score": score,
        "time_taken": timeTaken,
    };
}
