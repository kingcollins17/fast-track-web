

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'package:fasttrack_web/shared/shared.dart';

import 'package:fasttrack_web/find_icons_utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(statebox);
  runApp(const FastTrackWebApp());
  //runApp(const FindIconUtility());
}
