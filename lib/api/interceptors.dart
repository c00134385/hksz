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

    if(null == response.data['status']) {
      throw DioError(requestOptions: response.requestOptions, error: response.data);
    }

    if(200 != response.data['status']) {
      throw DioError(requestOptions: response.requestOptions, error: response.data);
    }

    handler.next(response);
  }
}
