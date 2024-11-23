import 'package:flutter/material.dart';
import 'extensions.dart';

const spacing = 8.0;

Widget spacer({double x = 8.0, double y = 8.0}) => SizedBox(width: x, height: y);

extension UIExt on Widget {
  Widget get left => Align(alignment: Alignment.centerLeft, child: this);

  Widget get right => Align(alignment: Alignment.centerRight, child: this);
  Widget get top => Align(alignment: Alignment.topCenter, child: this);
  Widget get bottom => Align(alignment: Alignment.bottomLeft, child: this);

  Widget get center => Center(child: this);
}

ButtonStyle button({
  double? x,
  double? y,
  bool rect = true,
  Color? bg,
  Color? fg,
}) =>
    ButtonStyle(
      fixedSize: x != null || y != null ? Size(x ?? 326.0, y ?? 48.0).prop : null,
      backgroundColor: bg?.prop,
      foregroundColor: fg?.prop,
      shape: rect ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)).prop : null,
    );
