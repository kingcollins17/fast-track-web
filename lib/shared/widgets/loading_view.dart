import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../theme.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitFadingCube(color: cyan, size: 40.0),
        SizedBox(height: 40),
        Text('Loading ...', style: TextStyle(fontSize: 16)),
      ],
    ));
  }
}
