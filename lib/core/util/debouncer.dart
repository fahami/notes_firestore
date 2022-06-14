import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;

  Debouncer({required this.milliseconds});
  Timer? timer;

  void run(VoidCallback callback) {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }

    timer = Timer(Duration(milliseconds: milliseconds), callback);
  }
}
