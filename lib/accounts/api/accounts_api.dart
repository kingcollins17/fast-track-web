import 'package:dio/dio.dart';
import 'package:fasttrack_web/shared/shared.dart';

typedef Token = ({String value, String type});

class AccountsApi extends BaseApi {
  AccountsApi(super.dio);

  Future<(String message, Token token)> signIn({
    String? username,
    String? email,
    String? password,
    String? googleId,
  }) async {
    cancelRequest();
    final Response(:data, :statusCode) = await dio.post(
      '$url/accounts/sign-in',
      data: {
        'username': username,
        'email': email,
        'password': password,
        'google_id': googleId,
      },
      cancelToken: cancelToken,
    );

    if (statusCode == null || statusCode != 200) {
      throw BaseApiException(
        message: data['detail'],
        statusCode: statusCode ?? 500,
      );
    }
    return (
      data['detail'].toString(),
      (
        value: data['data']['access_token'].toString(),
        type: data['data']['type'].toString(),
      )
    );
  }

  Future<String> signup({
    String? username,
    required String email,
    String? password,
    String? fullname,
  }) async {
    cancelRequest();
    final Response(:data, :statusCode) = await dio.post(
      '$url/accounts/sign-up',
      data: {
        'email': email,
        if (password != null) 'password': password,
        if (username != null) 'username': username,
        if (fullname != null) 'fullname': fullname,
      },
      cancelToken: cancelToken,
    );
    if (statusCode != 200) {
      throw BaseApiException(message: data['detail'], statusCode: statusCode!);
    }
    return data['detail'];
  }
}
