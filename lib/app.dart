import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/router.dart';
import 'package:fasttrack_web/shared/shared.dart';

class FastTrackWebApp extends StatelessWidget {
  const FastTrackWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: ValueListenableBuilder(
        valueListenable: FastTrackTheme.mode,
        builder: (context, value, child) {
          return MaterialApp.router(
          	debugShowCheckedModeBanner: false,
            title: 'FastTrack',
            theme: FastTrackTheme.light,
            darkTheme: FastTrackTheme.dark,
            themeMode: value,
            routerConfig: routerConfig,
          );
        }));
  }
}
