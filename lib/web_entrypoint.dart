// File: web_entrypoint.dart

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
// ignore: unused_import
import 'firebase_options.dart'; // correct path

import 'main.dart' as app;

void main() {
  setUrlStrategy(PathUrlStrategy());
  app.main(null);
}
