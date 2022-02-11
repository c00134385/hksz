import 'package:dio/dio.dart';

class TestInterceptor extends Interceptor {

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print('TestInterceptor onRequest() is called.  url: $options');
    handler.next(options);
  }
  
  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    print('TestInterceptor onResponse() is called. $response');
    if(null == response) {
      throw DioError(requestOptions: response.requestOptions, error: response.data);
    }

    print('response.headers: ${response.headers}');
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
