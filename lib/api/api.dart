import 'dart:async';
import 'package:dio/dio.dart' hide Response;
import 'package:hksz/model/models.dart';
import 'package:retrofit/retrofit.dart';

import 'interceptors.dart';

part 'api.g.dart';

@RestApi()
abstract class MyApi {
  factory MyApi(Dio dio, {String? baseUrl}) = _MyApi;

  @GET('/test')
  Future<Response> test();

  @POST('/nationality/getCertificateList')
  Future<Response<List<Certificate>>> getCertificateList();
}

class MyClient {
  static final MyClient _singleton = MyClient._internal();

  factory MyClient() {
    return _singleton;
  }

  MyApi? api;

  MyClient._internal() {
    BaseOptions options = BaseOptions();

    options.baseUrl = 'https://hk.sz.gov.cn:8118';
    // options.headers['content-type'] = 'application/x-www-form-urlencoded';
    // options.headers['timeoffset'] = DateTime.now().timeZoneOffset.inMilliseconds;
    options.connectTimeout = 30 * 1000;
    options.receiveTimeout = 30 * 1000;

    Dio _dio = Dio(options);

    // interceptors
    _dio.interceptors.add(TestInterceptor());

    api = MyApi(_dio);
  }
}
