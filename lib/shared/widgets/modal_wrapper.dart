import 'package:fasttrack_web/shared/shared.dart';
import 'package:fasttrack_web/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

enum ModalAlignment { top, center, bottom }

class ModalWrapper extends StatelessWidget {
  const ModalWrapper({super.key, required this.child, this.alignment = ModalAlignment.top});
  final Widget child;
  final ModalAlignment alignment;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: switch (alignment) {
        ModalAlignment.top => MainAxisAlignment.start,
        ModalAlignment.center => MainAxisAlignment.center,
        ModalAlignment.bottom => MainAxisAlignment.end,
        _ => MainAxisAlignment.start,
      },
      children: [
        Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        )
      ],
    );
  }
}
