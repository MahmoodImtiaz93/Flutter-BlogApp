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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(jsonDecode(response.body.toString())['message']),
        duration: Duration(milliseconds: 3000),
      ));

      break;
    case 422:
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(response.body)['errors'][0]),
        duration: Duration(milliseconds: 3000),
      ));
      //print(jsonDecode(response.body));
      break;
    case 400:
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(response.body)['message']),
        duration: Duration(milliseconds: 3000),
      ));
      //print(jsonDecode(response.body));
      break;
    case 403:
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(response.body)['message']),
        duration: Duration(milliseconds: 3000),
      ));
      //print(jsonDecode(response.body));
      break;
      // case 402:
      //   var newUrl = jsonDecode(response.body)['message'];
      //   if (newUrl != null) {
      //     // make a new HTTP request to the new URL
      //   } else {
      //     // handle error: location header is missing

      //   }
      //   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   //   content: Text(jsonDecode(response.body)['message']),
      //   //   duration: Duration(milliseconds: 3000),
      //   // ));
      //   print(jsonDecode(response.body)['message']);
      break;
    default:
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(jsonDecode(response.body)),
      //   duration: Duration(milliseconds: 3000),
      // ));

      print('default' + response.body);
  }
}
