import 'dart:io';

import 'package:blogapp/screen/home_screen.dart';
import 'package:blogapp/utils/colorfilter.dart';
import 'package:blogapp/utils/route_name.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:blogapp/model/post_model.dart';
import 'package:blogapp/provider/auth_provider.dart';
import 'package:blogapp/provider/post_provider.dart';

class AddPostScreen extends StatefulWidget {
  final bool isUpdate;
  final Posts? posts;

  AddPostScreen({
    Key? key,
    required this.isUpdate,
    this.posts,
  }) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtControllerBody = TextEditingController();
  bool _loading = false;
  File? _imageFile;
  final _picker = ImagePicker();
  String id = '';

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      _txtControllerBody.text = widget.posts!.body!;
      id = widget.posts!.id.toString();
      print(widget.posts!.image);
    }
  }

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

  void createPost() {
    Posts createPost =
        Posts(body: _txtControllerBody.text, image: _imageFile?.path);
    Provider.of<PostProvider>(context, listen: false)
        .createPost(createPost, context);
  }

  void updatePost() {
    Posts updatePosts = Posts(
      id: widget.posts!.id,
      userId: widget.posts!.userId,
      body: _txtControllerBody.text,
      image: widget.posts!.image,
      user: widget.posts!.user,
    );
    Provider.of<PostProvider>(context, listen: false)
        .updatePost(id, updatePosts, context);
    //  Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isUpdate == false
              ? "Add  Post"
              : "Edit Post"), //Text('${widget.title}'),
          backgroundColor: Colors.black,
        ),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(
                  // A value of 0.0 means no progress and 1.0 means that progress is complete.
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      image: _imageFile == null && widget.isUpdate
                          ? DecorationImage(
                              colorFilter: ColorFilters.greyscale,
                              image: NetworkImage(
                                  "http://192.168.0.106/Flutter-BlogApp-Backend/public/postedimage/${widget.posts!.image!}"),
                              fit: BoxFit.cover,
                            )
                          : _imageFile != null
                              ? DecorationImage(
                                  image: FileImage(_imageFile!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                    ),
                    child: Center(
                      child: IconButton(
                        icon: _imageFile != null
                            ? Icon(Icons.check_circle,
                                color: Colors.transparent)
                            : widget.isUpdate
                                ? Icon(Icons.check_circle,
                                    color: Colors.transparent)
                                : Icon(
                                    Icons.image,
                                    size: 50,
                                    color: Colors.black,
                                  ),
                        onPressed: () {
                          if (widget.isUpdate) {
                          } else {
                            getImage();
                          }
                        },
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _txtControllerBody,
                        keyboardType: TextInputType.multiline,
                        maxLines: 9,
                        validator: (value) =>
                            value!.isEmpty ? 'Post Title is Required!!!' : null,
                        decoration: InputDecoration(
                          hintText: "Post Title . . .",
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.isUpdate) {
                          updatePost();
                        } else {
                          createPost();
                        }

                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            // _loading = !_loading;
                          });
                        }
                      },
                      child: Text(
                        'Post',
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        minimumSize: const Size(50, 50),
                        maximumSize: const Size(50, 50),
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
    );
  }
}
