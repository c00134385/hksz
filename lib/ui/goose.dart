import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:hksz/api/api.dart';
import 'package:hksz/api/interceptors.dart';
import 'package:cookie_jar/cookie_jar.dart';

class Goose {

  Dio? _dio;
  MyApi? _api;

  final String certNo;
  final String pwd;

  Goose({required this.certNo, required this.pwd}) {
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

    _api = MyApi(_dio!);
  }

  login() {
    // _api.login(certType, certNo, pwd, verifyCode)
  }
}