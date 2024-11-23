import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension HelpersExt<T> on T {
  ValueNotifier<T> get valueX => ValueNotifier(this);

  WidgetStatePropertyAll<T> get prop => WidgetStatePropertyAll(this);
}

extension DurationExt on int {
  Duration get sec => Duration(seconds: this);

  Duration get ms => Duration(milliseconds: this);
}

extension ContextExt on BuildContext {

  Size get xsize => MediaQuery.of(this).size;


  ColorScheme get colors => Theme.of(this).colorScheme;

  /// Route query parameters
  Map<String, String> get params => GoRouterState.of(this).uri.queryParameters;

  /// Current routes uri
  Uri get uri => GoRouterState.of(this).uri;
}

extension StateHelperExt<T extends StatefulWidget> on State<T> {
	
  void attach(ValueNotifier notifier) {
    notifier.addListener(() => setState(() {}));
  }
}
