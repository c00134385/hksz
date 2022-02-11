// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestModel _$TestModelFromJson(Map<String, dynamic> json) {
  return TestModel()..count = json['count'] as int?;
}

Map<String, dynamic> _$TestModelToJson(TestModel instance) => <String, dynamic>{
      'count': instance.count,
    };

Response<T> _$ResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return Response<T>()
    ..status = json['status'] as int?
    ..msg = json['msg'] as String?
    ..data = _$nullableGenericFromJson(json['data'], fromJsonT);
}

Map<String, dynamic> _$ResponseToJson<T>(
  Response<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

Certificate _$CertificateFromJson(Map<String, dynamic> json) {
  return Certificate()
    ..id = json['id'] as int?
    ..name = json['name'] as String?;
}

Map<String, dynamic> _$CertificateToJson(Certificate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
