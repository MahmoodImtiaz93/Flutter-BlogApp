import 'package:blogapp/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:blogapp/components/custome_textfield.dart';
import 'package:blogapp/model/comment_model.dart';
import 'package:blogapp/provider/comment_provider.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentScreen extends StatefulWidget {
  final int? postId;
  final int? commentcount;
  final Comments? comments;
  final String? image;

  CommentScreen({
    Key? key,
    this.postId,
    this.commentcount,
    this.comments,
    this.image,
  }) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  int userID = 0;
  final _formKey = GlobalKey<FormState>();
  int editID = 0;
  bool isUpdate = false;
  TextEditingController _commentControllerBody = TextEditingController();
  @override
  void initState() {
    super.initState();

    _fetchComments();
  }

  Future<void> _fetchComments() async {
    CommentProvider commentProvider =
        Provider.of<CommentProvider>(context, listen: false);
    await commentProvider.getAllComments(widget.postId, context);
    commentProvider.savedUserInfo().then((String? userInfo) {
      userID = int.parse(userInfo!);
    });
  }

  createComments() {
    Commentss createComments = Commentss(comment: _commentControllerBody.text);
    Provider.of<CommentProvider>(context, listen: false)
        .createComment(widget.postId!, createComments, context);
  }

  updateComments() {
    Commentss updateComments = Commentss(comment: _commentControllerBody.text);
    Provider.of<CommentProvider>(context, listen: false)
        .updateComment(editID, updateComments, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: Colors.black,
          onRefresh: () {
            return _fetchComments();
          },
          child: Column(
            children: [
              Expanded(
                child: Consumer<CommentProvider>(
                  builder: (context, value, child) {
                    return AnimationLimiter(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: value.commentModel.length,
                        itemBuilder: (context, index) {
                          final DateTime parsedDateTime = DateTime.parse(
                              value.commentModel[index].createdAt!);
                          final now = DateTime.now();
                          final difference = now.difference(parsedDateTime);
                          final formattedTimestamp =
                              timeago.format(now.subtract(difference));

                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 1000),
                            delay: const Duration(milliseconds: 100),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: SafeArea(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onLongPress: () {
                                          if (value.commentModel[index].user!
                                                  .id! ==
                                              userID) {
                                       
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  color: Colors.black,
                                                  height: 100,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30.0),
                                                                ),
                                                              ),
                                                              child: const Text(
                                                                'Edit',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              onPressed: () {
                                                                isUpdate = true;
                                                                editID = value
                                                                    .commentModel[
                                                                        index]
                                                                    .id!;
                                                                _commentControllerBody
                                                                        .text =
                                                                    value
                                                                        .commentModel[
                                                                            index]
                                                                        .comment!;
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30.0),
                                                                ),
                                                              ),
                                                              child: const Text(
                                                                'Delete',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              onPressed: () {
                                                                value.deleteComment(
                                                                    value
                                                                        .commentModel[
                                                                            index]
                                                                        .id!,
                                                                    context);

                                                                Navigator.pop(
                                                                    context);
                                                                // setState(() {
                                                                //   _fetchComments();
                                                                // });
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                );
                                              },
                                            );
                                          } else {}
                                        },
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 32,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 30,
                                                          child: ClipOval(
                                                            child: value
                                                                        .commentModel[
                                                                            index]
                                                                        .user
                                                                        ?.propic !=
                                                                    null
                                                                ? ColorFiltered(
                                                                    colorFilter:
                                                                        const ColorFilter
                                                                            .mode(
                                                                      Colors
                                                                          .grey,
                                                                      BlendMode
                                                                          .saturation,
                                                                    ),
                                                                    child: FadeInImage
                                                                        .assetNetwork(
                                                                      placeholder:
                                                                          'assets/images/propic.JPG',
                                                                      image: value
                                                                              .commentModel[index]
                                                                              .user!
                                                                              .propic!
                                                                              .isNotEmpty
                                                                          ? "http://192.168.0.106/Flutter-BlogApp-Backend/public/profile-pictures/${value.commentModel[index].user!.propic!}"
                                                                          : 'assets/images/propic.JPG',
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      width: 80,
                                                                      height:
                                                                          80,
                                                                    ),
                                                                  )
                                                                : Image.asset(
                                                                    'assets/images/propic.JPG',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    width: 80,
                                                                    height: 80,
                                                                  ),
                                                          ),
                                                        ),
                                                      )),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10), // radius of 10
                                                                color: Colors
                                                                    .black // green as background color
                                                                ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      20.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text.rich(
                                                                TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text: value
                                                                          .commentModel[
                                                                              index]
                                                                          .user!
                                                                          .name!,
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                    const TextSpan(
                                                                        text:
                                                                            "   "),
                                                                    TextSpan(
                                                                      text: formattedTimestamp +
                                                                          "\n",
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontSize:
                                                                            11,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                value
                                                                    .commentModel[
                                                                        index]
                                                                    .comment!,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          controller: _commentControllerBody,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "Comment",
                            hintStyle: const TextStyle(
                                fontSize: 16.0, color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Colors.black45,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.black),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              //<-- SEE HERE
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (isUpdate) {
                          updateComments();
                          _commentControllerBody.clear();
                        } else {
                          createComments();
                        }
                        _commentControllerBody.clear();
                        editID = 0;
                      }
                      setState(() {
                        _fetchComments();
                      });
                    },
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
