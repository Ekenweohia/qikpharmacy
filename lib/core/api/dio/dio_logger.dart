import 'package:dio/dio.dart';
import 'package:loggy/loggy.dart';

class DioLogger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logInfo('${options.method} - ${options.uri}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logDebug('${response.statusCode} - ${response.statusMessage}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logError('${err.type} - ${err.message}');
    return super.onError(err, handler);
  }
}
