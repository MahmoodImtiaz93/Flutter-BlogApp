import 'package:flutter/material.dart';

final _messangerKey = GlobalKey<ScaffoldMessengerState>();

void showSnackBar(BuildContext context, String text) {
  _messangerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
