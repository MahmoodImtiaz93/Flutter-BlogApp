import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<String> pickImages() async {
  String imageNames = '';

  try {
    var files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        imageNames += files.files[i].name;
        if (i != files.files.length - 1) {
          imageNames += ', '; // Add a delimiter between filenames
        }
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return imageNames;
}

Expanded kLikeAndComment(
    int value, IconData icon, Color color, Function onTap) {
  return Expanded(
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(width: 4),
              Text('$value'),
            ],
          ),
        ),
      ),
    ),
  );
}
