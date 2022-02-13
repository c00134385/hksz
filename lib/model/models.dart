import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'models.g.dart';

@JsonSerializable()
class TestModel {
  int? count;

  TestModel();

  factory TestModel.fromJson(Map<String, dynamic> json) => _$TestModelFromJson(json);
  Map<String, dynamic> toJson() => _$TestModelToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class UserAccount {
  int? certType;
  String? certNo;
  String? pwd;
  Certificate? certificate;

  // UserAccount();

  // factory UserAccount.fromJson(Map<String, dynamic> json) => _$UserAccountFromJson(json);
  // Map<String, dynamic> toJson() => _$UserAccountToJson(this);

  UserAccount.fromString(String src) {
    var array = src.split(',');
    certType = int.tryParse(array[0]);
    certNo = array[1].trim();
    pwd = array[2].trim();
  }
}

@JsonSerializable(genericArgumentFactories: true)
class Response<T> {
  int? status;
  String? msg;
  T? data;

  Response();

  factory Response.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ResponseFromJson<T>(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T? value) toJsonT) => _$ResponseToJson(this, toJsonT);

  @override
  String toString() {
    return jsonEncode(toJson((value) => value.toString()));
  }
}

@JsonSerializable()
class Certificate {
  int? id;
  String? name;

  Certificate();

  factory Certificate.fromJson(Map<String, dynamic> json) => _$CertificateFromJson(json);
  Map<String, dynamic> toJson() => _$CertificateToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

@JsonSerializable()
class LoginResult {
  int? fillStatus;
  String? redirect_uri;

  LoginResult();

  factory LoginResult.fromJson(Map<String, dynamic> json) => _$LoginResultFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResultToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

@JsonSerializable()
class RoomInfo {
  int? id;
  DateTime? date;
  int? count;
  int? total;
  int? timespan;
  String? sign;

  RoomInfo();

  factory RoomInfo.fromJson(Map<String, dynamic> json) => _$RoomInfoFromJson(json);
  Map<String, dynamic> toJson() => _$RoomInfoToJson(this);
}

@JsonSerializable()
class UserInfo {
  int? id;
  String? idCode;
  String? mobile;
  String? userName;
  String? nationality;
  String? address;
  String? area;
  DateTime? birthday;
  String? certNo;
  int? certType;

  UserInfo();

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
