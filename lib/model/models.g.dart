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

UserAccount _$UserAccountFromJson(Map<String, dynamic> json) {
  return UserAccount()
    ..certType = json['certType'] as int?
    ..certNo = json['certNo'] as String?
    ..pwd = json['pwd'] as String?;
}

Map<String, dynamic> _$UserAccountToJson(UserAccount instance) =>
    <String, dynamic>{
      'certType': instance.certType,
      'certNo': instance.certNo,
      'pwd': instance.pwd,
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

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) {
  return LoginResult()
    ..fillStatus = json['fillStatus'] as int?
    ..redirect_uri = json['redirect_uri'] as String?;
}

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'fillStatus': instance.fillStatus,
      'redirect_uri': instance.redirect_uri,
    };

RoomInfo _$RoomInfoFromJson(Map<String, dynamic> json) {
  return RoomInfo()
    ..id = json['id'] as int?
    ..date =
        json['date'] == null ? null : DateTime.parse(json['date'] as String)
    ..count = json['count'] as int?
    ..total = json['total'] as int?
    ..timespan = json['timespan'] as int?
    ..sign = json['sign'] as String?;
}

Map<String, dynamic> _$RoomInfoToJson(RoomInfo instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'count': instance.count,
      'total': instance.total,
      'timespan': instance.timespan,
      'sign': instance.sign,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo()
    ..id = json['id'] as int?
    ..idCode = json['idCode'] as String?
    ..mobile = json['mobile'] as String?
    ..userName = json['userName'] as String?
    ..nationality = json['nationality'] as String?
    ..address = json['address'] as String?
    ..area = json['area'] as String?
    ..birthday = json['birthday'] == null
        ? null
        : DateTime.parse(json['birthday'] as String)
    ..certNo = json['certNo'] as String?
    ..certType = json['certType'] as int?;
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'idCode': instance.idCode,
      'mobile': instance.mobile,
      'userName': instance.userName,
      'nationality': instance.nationality,
      'address': instance.address,
      'area': instance.area,
      'birthday': instance.birthday?.toIso8601String(),
      'certNo': instance.certNo,
      'certType': instance.certType,
    };
