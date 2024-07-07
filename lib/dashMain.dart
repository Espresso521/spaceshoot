import 'package:dashbook/dashbook.dart';
import 'package:flutter/material.dart';

import 'camera_and_viewport/camera_and_viewport.dart';

void main() {
  final dashbook = Dashbook();
  addCameraAndViewportStories(dashbook);
  runApp(dashbook);
}
