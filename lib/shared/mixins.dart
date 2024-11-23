import 'package:flutter/material.dart';

mixin FormControllers on Object {
  List<TextEditingController> get controllers;

  void disposeControllers() {
    for (var controller in controllers) {
      controller.dispose();
    }
  }
}
