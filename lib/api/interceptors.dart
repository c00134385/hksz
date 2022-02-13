import 'package:dio/dio.dart';

class TestInterceptor extends Interceptor {

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // print('TestInterceptor onRequest() is called.  url: $options');
    // print('request.headers:');
    // options.headers.forEach((key, value) {
    //   print('  $key: $value');
    // });
    if(options.path.contains('/user/getVerify?')) {
      options.responseType = ResponseType.bytes;
    }
    // print('options.responseType: ${options.responseType}');
    handler.next(options);
  }
  
  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    // print('TestInterceptor onResponse() is called.');
    // if(null == response) {
    //   throw DioError(requestOptions: response.requestOptions, error: response.data);
    // }

    // print('response.headers: ${response.headers}');
    // print('response.headers:');
    // response.headers.map.forEach((key, value) {
    //   print('  $key: $value');
    // });
    // if(response.headers.value('')) {
    //
    // }

    // if(null != response.data && 200 != response.data['status']) {
    //   throw DioError(requestOptions: response.requestOptions, error: response.data);
    // }

    // if() {
    //   throw DioError(requestOptions: response.requestOptions, error: response.data);
    // }

    handler.next(response);
  }
}
