// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animations/animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fasttrack_web/shared/shared.dart';

import '../widgets/widgets.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final view = _DisplayedView.signin.valueX;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.xsize.width,
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            spacer(y: spacing * 4),
            spacer(y: spacing),
            SizedBox(
              height: context.xsize.height * 0.8,
              child: ValueListenableBuilder(
                  valueListenable: view,
                  builder: (context, value, _) {
                    return PageTransitionSwitcher(
                      duration: 600.ms,
                      reverse: value == _DisplayedView.signup,
                      transitionBuilder: (child, primary, secondary) => SharedAxisTransition(
                        animation: primary,
                        secondaryAnimation: secondary,
                        transitionType: SharedAxisTransitionType.scaled,
                        child: child,
                      ),
                      child: value == _DisplayedView.signin
                          ? SignInView(onChangeView: () => view.value = _DisplayedView.signup)
                          : SignUpView(onChangeView: () => view.value = _DisplayedView.signin),
                    );
                  }),
            ),
            spacer(y: spacing * 2),
          ],
        ),
      ),
    );
  }
}

enum _DisplayedView { signin, signup, otp }
