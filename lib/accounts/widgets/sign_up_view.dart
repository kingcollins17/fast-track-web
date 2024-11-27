// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fasttrack_web/accounts/api/accounts_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:fasttrack_web/shared/shared.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key, this.onChangeView});
  final void Function()? onChangeView;

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final isLoading = false.valueX;
  final obscure = true.valueX;
  final formKey = GlobalKey<FormState>();

  String? email, fullname, password;
  @override
  void initState() {
    attach(isLoading);
    attach(obscure);
    super.initState();
  }

  Flusher get flusher => ref.read(flusherProvider.notifier);
  Future<void> signup() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        isLoading.value = true;
        final res = await AccountsApi(ref.read(dioClientProvider)).signup(
          email: email!,
          password: password,
          fullname: fullname,
        );
        flusher.notify(res, context: context);
      }
    } catch (e) {
      flusher.notify(
      e is BaseApiException ? e.message : '$e',
        context: context,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final factor = 0.35;
    return SizedBox(
      width: context.xsize.width * 0.9,
      child: Padding(
        padding: const EdgeInsets.only(bottom: spacing * 2),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create your FastTrack Account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: spacing * 3, fontWeight: FontWeight.w700),
              ),
              Text(
                'Sign up with FastTrack to start tackling deadlines like a Pro',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: context.colors.onSurface.withOpacity(0.4),
                ),
              ),
              spacer(y: spacing * 3),
              InputField(
                onChanged: (value) => fullname = value,
                label: 'Fullname - Optional',
                hint: 'Enter your email or username',
              ),
              spacer(y: spacing * 2),
              InputField(
                onChanged: (value) => email = value,
                label: 'Email',
                hint: 'Enter your email',
              ),
              spacer(y: spacing * 2),
              InputField(
                onChanged: (value) => password = value,
                label: 'Password',
                hint: '',
                suffixIcon: GestureDetector(
                  onTap: () => obscure.value = !obscure.value,
                  child: Icon(
                    obscure.value ? Icons.visibility : Icons.visibility_off,
                    color: context.colors.onSurface.withOpacity(0.6),
                  ),
                ),
              ),
              spacer(y: spacing * 2),
              FilledButton(
                style: button(x: context.xsize.width * 0.9, rect: false),
                      onPressed: isLoading.value ? null : signup,
                      child: isLoading.value
                          ? SpinKitRing(size: spacing * 3, lineWidth: 2.0, color: Colors.white)
                          : Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ))
                  .left,
              spacer(y: spacing),
              GestureDetector(
                onTap: widget.onChangeView,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Already have an account? Sign in here'),
                ),
              ),
              spacer(y: spacing * 2),
            ],
          ),
        ),
      ),
    );
  }
}
