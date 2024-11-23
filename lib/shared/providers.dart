// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ui.dart';
import 'util.dart';
import 'theme.dart';
import 'saveable_state.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
class DioClient extends _$DioClient with SaveableState<Dio> {
  @override
  Dio build() {
    return load() ?? Dio(BaseOptions(validateStatus: (_) => true));
  }

  void authorize(String jwtToken, [String? email]) async {
    final prev = state.options;
    state.close();
    state = Dio(prev.copyWith(headers: {
      'Authorization': 'Bearer $jwtToken',
      if (email != null) 'X-email': email,
    }));
    save();
  }

  void authorizeSilently(String jwtToken, [String? email]) async {
    state.options.headers['Authorization'] = 'Bearer $jwtToken';
    if (email != null) state.options.headers['X-email'] = email;
    save();
  }

  void logout() {
    state = Dio(state.options.copyWith(headers: {}));
    delete();
  }

  @override
  Dio fromJson(json) {
    final jwtToken = json['accessToken'];
    final email = json['X-email'];
    return Dio(BaseOptions(validateStatus: (_) => true, headers: {
      if (jwtToken != null) 'Authorization': 'Bearer $jwtToken',
      if (email != null) 'X-email': email,
    }));
  }

  @override
  String get key => 'dio_client';

  @override
  Map<String, dynamic> toJson(Dio state) => {
        'accessToken': state.accessToken,
        'X-email': state.options.headers['X-email'],
      };

  @override
  Dio get value => state;
}

extension ExtractToken on Dio {
  String? get accessToken => options.headers['Authorization']?.toString().split(' ').last;
}

final class AuthState {
  final String? accessToken, email, avatar;
  const AuthState._({this.accessToken, this.email, this.avatar});

  bool get isAuthenticated => !isNotAuthenticated;

  bool get isNotAuthenticated => accessToken == null || accessToken!.isEmpty;

  AuthState copyWith({String? token}) => AuthState._(accessToken: token ?? accessToken);

  @override
  toString() =>
      'AuthState<\nisAuthenticated=$isAuthenticated,\nemail=$email,\naccessToken=$accessToken\n>';
}

@riverpod
class Flusher extends _$Flusher {
  @override
  Flushbar? build() {
    return null;
  }

  void notify(
      {required String message,
      Duration? duration,
      FlushbarPosition? position,
      double? width,
      BuildContext? context}) {
    duration ??= const Duration(seconds: 4);

    final ticker = CustomTickerProvider();
    final _controller = AnimationController(vsync: ticker);
    _controller.duration = duration;
    _controller.forward();

    const radius = Radius.circular(12);
    state = Flushbar(
      //message: message,
      maxWidth: width ?? 320.0,
      borderRadius: const BorderRadius.only(bottomLeft: radius, bottomRight: radius),
      isDismissible: false,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      messageText: Text(message, style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.6),)),
      backgroundColor: Colors.white,
      duration: duration,
      showProgressIndicator: true,
      progressIndicatorController: _controller,

      //progressIndicatorBackgroundColor: Colors.red,
      boxShadows: [
        const BoxShadow(color: Color(0x45151515), blurRadius: 18),
      ],
      flushbarPosition: position ?? FlushbarPosition.TOP,
      progressIndicatorValueColor: ConstantTween<Color>(cyan).animate(_controller),
    );
    if (context != null) state?.show(context);
  }
}
