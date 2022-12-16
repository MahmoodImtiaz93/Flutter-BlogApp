import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/snackbar.dart';
void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 422:
      showSnackBar(context, jsonDecode(response.body)['errors']);
      break;
    case 403:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}