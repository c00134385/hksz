import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class TestModel {
  int? count;

  TestModel();

  factory TestModel.fromJson(Map<String, dynamic> json) => _$TestModelFromJson(json);
  Map<String, dynamic> toJson() => _$TestModelToJson(this);
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
}

@JsonSerializable()
class Certificate {
  int? id;
  String? name;

  Certificate();

  factory Certificate.fromJson(Map<String, dynamic> json) => _$CertificateFromJson(json);
  Map<String, dynamic> toJson() => _$CertificateToJson(this);
}
