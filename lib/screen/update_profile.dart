import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:blogapp/provider/auth_provider.dart';

class UpdateProfile extends StatefulWidget {
  final int? userID;
  UpdateProfile({
    Key? key,
    this.userID,
  }) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  File? _imageFile;
  final _picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  String? getStringImage(File? file) {
    if (file == null) return null;
    return file.path;
  }

  AuthProvider authProvider = AuthProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Update Profile'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Set the shape to circle
                    image: _imageFile != null
                        ? DecorationImage(
                            image: FileImage(_imageFile!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Center(
                    child: IconButton(
                      icon: _imageFile != null
                          ? Icon(Icons.check_circle, color: Colors.transparent)
                          : Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.black,
                            ),
                      onPressed: () {
                        getImage();
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    authProvider.updateProfilePic(
                        context, widget.userID!, _imageFile!);
                  },
                  child: Text(
                    'Upload',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    minimumSize: const Size(100, 50),
                    maximumSize: const Size(200, 200),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    //side: BorderSide(width: 4, color: Colors.black38),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
