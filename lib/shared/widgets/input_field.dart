import 'package:flutter/material.dart';

import '../ui.dart';
import '../extensions.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.controller,
    this.onChanged,
    this.hint,
    this.label,
    this.suffixText,
    this.prefixText,
    this.height,
    this.width,
    this.obscureText = false,
    this.validator,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
  });
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? hint, label, suffixText, prefixText;
  final double? height, width;
  final bool obscureText;
  final Widget? prefix, suffix, prefixIcon, suffixIcon;

  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          validator: validator,
          style: TextStyle(
            fontSize: 14,
            color: context.colors.onSurface.withOpacity(0.8),
          ),
          decoration: InputDecoration(
              prefix: prefix,
              suffix: suffix,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              labelText: label,
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 14,
                color: context.colors.onSurface.withOpacity(0.4),
              ),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: context.colors.onSurface),
              )),
        ),
      ),
    );
  }
}
