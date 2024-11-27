// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fasttrack_web/shared/shared.dart';

import '../providers/providers.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key, this.onChangeView});
  final void Function()? onChangeView;

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final obscure = true.valueX;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    attach(obscure);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final factor = 0.35;
    final authState = ref.watch(authProvider);
    final auth = ref.read(authProvider.notifier);
    final screen = context.xsize;
    final media = Breakpoints.media(screen.width);
    return SizedBox(
      width: media == Breakpoints.mobile ? screen.width * 0.9 : null,
      child: Padding(
        padding: const EdgeInsets.only(bottom: spacing * 2),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In to FastTrack',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: spacing * 3, fontWeight: FontWeight.w700),
              ),
              Text(
                'Sign in to your FastTrack account to stay ahead of deadlines',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: context.colors.onSurface.withOpacity(0.4),
                ),
              ),
              spacer(y: spacing * 3),
              InputField(
                label: 'Email',
                hint: 'Enter your email or username',
                controller: auth.email,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter your email or username' : null,
              ),
              spacer(y: spacing * 2),
              ValueListenableBuilder(
                  valueListenable: obscure,
                  builder: (context, value, __) {
                    return InputField(
                      label: 'Password',
                      hint: '',
                      obscureText: value,
                      controller: auth.password,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter your password' : null,
                      suffixIcon: GestureDetector(
                        onTap: () => obscure.value = !value,
                        child: Icon(
                          value ? Icons.visibility : Icons.visibility_off,
                          color: context.colors.onSurface.withOpacity(0.6),
                        ),
                      ),
                    );
                  }),
              spacer(y: spacing * 2),
              FilledButton(
                style: button(rect: false, x: screen.width * 0.9),
                onPressed: authState.isLoading
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        auth.signIn(context: context, formKey: formKey);
                      },
                child: authState.isLoading
                    ? SpinKitRing(color: Colors.white, size: spacing * 3, lineWidth: 2.0)
                    : Text('Sign in', style: TextStyle(color: Colors.white, fontSize: spacing * 2)),
              ).left,
              spacer(y: spacing),
              GestureDetector(
                onTap: widget.onChangeView,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Don\'t have an account? Sign up here'),
                ),
              ),
              spacer(y: spacing),
              spacer(y: spacing * 2),
            ],
          ),
        ),
      ),
    );
  }
}
