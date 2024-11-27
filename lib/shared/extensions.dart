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

extension HelperExt2 on DateTime {
  String get readable {
    final dateTime = this;
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    final month = months[dateTime.month - 1];
    final day = dateTime.day;
    final year = dateTime.year;

    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$month $day, $year at $hour:$minute $period';
  }
}

extension StateHelperExt<T extends StatefulWidget> on State<T> {
  void attach(ValueNotifier notifier) {
    notifier.addListener(() => setState(() {}));
  }
}
