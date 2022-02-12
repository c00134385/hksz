import 'dart:async';
import 'package:dio/dio.dart' hide Response;
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:hksz/model/models.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'interceptors.dart';

part 'api.g.dart';

@RestApi()
abstract class MyApi {
  factory MyApi(Dio dio, {String? baseUrl}) = _MyApi;

  @GET('/test')
  Future<Response> test();

  @POST('/nationality/getCertificateList')
  Future<Response<List<Certificate>>> getCertificateList();

  @GET('/user/getVerify?{random}')
  Future getVerify(@Path('random') String random);

  @POST('/user/login')
  Future<Response<LoginResult>> login(
    @Field('certType') int certType,
    @Field('certNo') String certNo,
    @Field('pwd') String pwd,
    @Field('verifyCode') String verifyCode,
  );

  @GET('/user/logout')
  Future logout();

  @POST('/user/getUserInfo')
  Future<Response<UserInfo>> getUserInfo();

  @POST('/passInfo/userCenterIsCanReserve')
  Future<Response<dynamic>> isCanReserve();

  @POST('/orderInfo/getCheckInDate"')
  Future<Response<dynamic>> getCheckInDate();

  @POST('/passInfo/gerReserveOrderInfo')
  Future<Response<dynamic>> getReserveOrderInfo();

}

class MyClient {
  static final MyClient _singleton = MyClient._internal();

  factory MyClient() {
    return _singleton;
  }

  Dio? _dio;
  MyApi? api;

  MyClient._internal() {
    BaseOptions options = BaseOptions();

    options.baseUrl = 'https://hk.sz.gov.cn:8118';
    options.headers['content-type'] = 'application/x-www-form-urlencoded';
    // options.headers['timeoffset'] = DateTime.now().timeZoneOffset.inMilliseconds;
    options.connectTimeout = 30 * 1000;
    options.receiveTimeout = 30 * 1000;

    _dio = Dio(options);

    // interceptors
    _dio?.interceptors.add(CookieManager(CookieJar()));
    _dio?.interceptors.add(TestInterceptor());

    api = MyApi(_dio!);
  }

  // Future<dynamic> getVerify(random) async {
  //   const _extra = <String, dynamic>{};
  //   final queryParameters = <String, dynamic>{};
  //   final _data = <String, dynamic>{};
  //   final _result = await _dio.fetch(_setStreamType<dynamic>(
  //       Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
  //           .compose(_dio.options, '/user/getVerify?$random',
  //           queryParameters: queryParameters, data: _data)
  //           .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
  //   final value = _result.data;
  //   return value;
  // }
}
