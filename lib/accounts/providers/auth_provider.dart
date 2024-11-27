import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fasttrack_web/shared/shared.dart';

import '../api/api.dart';

part 'auth_provider.g.dart';

final class AuthState {
  final String? accessToken;

  bool get isAuthenticated => accessToken != null;

  bool get isNotAuthenticated => !isAuthenticated;

  AuthState._({this.accessToken});

  @override
  toString() =>
      'AuthState{accessToken: ${accessToken?.substring(0, 10)}, isAuthenticated: $isAuthenticated}';
}

@Riverpod(keepAlive: true)
class Auth extends _$Auth with FormControllers {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Future<AuthState> build() async {
    ref.onDispose(disposeControllers);
    final dio = ref.watch(dioClientProvider);
    return AuthState._(accessToken: dio.accessToken);
  }

  Dio get dio => ref.read(dioClientProvider);

  Flusher get flusher => ref.read(flusherProvider.notifier);

  Future<void> signIn({
    GlobalKey<FormState>? formKey,
    BuildContext? context,
  }) async {
    if ((formKey?.currentState?.validate() ?? false)) {
      state = const AsyncLoading();
      state = await AsyncValue.guard(() async {
        try {
          final api = AccountsApi(dio);

          final (message, (:type, :value)) = await api.signIn(
            email: email.text.trim(),
            password: password.text.trim(),
          );
          flusher.notify(message, context: context);
          ref.read(dioClientProvider.notifier).authorizeSilently(value);
          context?.push('/organization');
          return AuthState._(accessToken: value);
        } catch (e) {
          flusher.notify(
            e is BaseApiException
                ? e.message
                : e is DioException
                    ? e.error.toString()
                    : '$e',
            context: context,
          );
          rethrow;
        }
      });
    } else {
      throw Exception('Input is invalid');
    }
  }

  @override
  List<TextEditingController> get controllers => [email, password];
}
