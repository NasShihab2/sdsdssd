import 'dart:convert';

BookAppointMentErrorModel bookAppointMentErrorModelFromJson(String str) => BookAppointMentErrorModel.fromJson(json.decode(str));

String bookAppointMentErrorModelToJson(BookAppointMentErrorModel data) => json.encode(data.toJson());

class BookAppointMentErrorModel {
  bool? status;
  int? success;
  Errors? errors;

  BookAppointMentErrorModel({
    this.status,
    this.success,
    this.errors,
  });

  factory BookAppointMentErrorModel.fromJson(Map<String, dynamic> json) => BookAppointMentErrorModel(
    status: json["Status"],
    success: json["success"],
    errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "success": success,
    "errors": errors?.toJson(),
  };
}

class Errors {
  List<String>? bookAppointmentId;

  Errors({
    this.bookAppointmentId,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    bookAppointmentId: json["bookAppointmentId"] == null ? [] : List<String>.from(json["bookAppointmentId"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "bookAppointmentId": bookAppointmentId == null ? [] : List<dynamic>.from(bookAppointmentId!.map((x) => x)),
  };
}