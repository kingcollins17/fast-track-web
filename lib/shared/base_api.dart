import 'package:dio/dio.dart';

const baseurl = 'https://fast-track-server.onrender.com/api/v1';

abstract class BaseApi {
  final String url;
  final Dio dio;

  Duration timeout;

  /// Use this cancel token in your request
  CancelToken cancelToken = CancelToken();

  BaseApi(
    this.dio, {
    this.url = baseurl,
    this.timeout = const Duration(seconds: 20),
  });

  /// Schedule a cancel operation in the future when timeout is exceeded
  Future<void> cancelRequest([Duration? timeout]) async {
    await Future.delayed(timeout ?? this.timeout);
    cancelToken.cancel();
    cancelToken = CancelToken();
  }

  /// Cancel Ongoing requests immediately
  void cancelRequestNow() {
    cancelToken.cancel();
    cancelToken = CancelToken();
  }
}

class BaseApiException implements Exception {
  final String message;
  final stackTrace = StackTrace.current;
  final int statusCode;

  BaseApiException({required this.message, required this.statusCode});

  @override
  toString() => 'BaseApiException<message=$message, statusCode=$statusCode>';
}
