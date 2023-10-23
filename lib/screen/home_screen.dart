 
import 'dart:ui';

import 'package:blogapp/model/post_model.dart';
import 'package:blogapp/provider/post_provider.dart';
import 'package:blogapp/screen/add_post_screen.dart';
import 'package:blogapp/screen/comment_screen.dart';
 
import 'package:blogapp/utils/functions.dart';
 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int userID = 0;
  String formattedTimestamp = '';
  String editedTimestamp = '';

 
  @override
  Widget build(BuildContext context) {
    PostProvider postProvider =
        Provider.of<PostProvider>(context, listen: false);
    postProvider.getAllPosts(context);

    postProvider.savedUserInfo().then((String? userInfo) {
      userID = int.parse(userInfo!);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: Colors.black,
          onRefresh: () {
            return postProvider.getAllPosts(context);
          },
          child: Consumer<PostProvider>(
            builder: (context, p_value, child) {
              return p_value.postModel.isEmpty
                  ? Center(
                      child: Text(
                      "No one posted yet!",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ))
                  : ListView.builder(
                      itemCount: p_value.postModel.length,
                      itemBuilder: (context, index) {
                        Posts currentPost = p_value.postModel[index];

                        if (currentPost.createdAt != null) {
                          final DateTime parsedDateTime =
                              DateTime.parse(currentPost.createdAt!);
                          final now = DateTime.now();
                          final difference = now.difference(parsedDateTime);
                          formattedTimestamp =
                              timeago.format(now.subtract(difference));
                        } else {
                         
                        }

                        if (currentPost.updatedAt != null) {
                          final DateTime parsedDateTime =
                              DateTime.parse(currentPost.updatedAt!);
                          final now = DateTime.now();
                          final difference = now.difference(parsedDateTime);
                          editedTimestamp =
                              timeago.format(now.subtract(difference));
                        } else {
                          
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 28,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 25,
                                      child: ClipOval(
                                        child: p_value.postModel[index].user
                                                    ?.propic !=
                                                null
                                            ? ColorFiltered(
                                                colorFilter: const ColorFilter.mode(
                                                  Colors.grey,
                                                  BlendMode.saturation,
                                                ),
                                                child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      'assets/images/propic.JPG',
                                                  image:
                                                      "http://192.168.0.106/Flutter-BlogApp-Backend/public/profile-pictures/${p_value.postModel[index].user!.propic!}",
                                                  fit: BoxFit.cover,
                                                  width: 80,
                                                  height: 80,
                                                ),
                                              )
                                            : Image.asset(
                                                'assets/images/propic.JPG',
                                                fit: BoxFit.cover,
                                                width: 80,
                                                height: 80,
                                              ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    currentPost.user!.name!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Text(
                                    formattedTimestamp,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  trailing: currentPost.user!.id! == userID
                                      ? PopupMenuButton(
                                          child: const Icon(
                                            Icons.more_vert,
                                            color: Colors.white,
                                          ),
                                          itemBuilder: (context) => [
                                            const PopupMenuItem(
                                              child: Text('Edit'),
                                              value: 'edit',
                                            ),
                                            const PopupMenuItem(
                                              child: Text('Delete'),
                                              value: 'delete',
                                            ),
                                          ],
                                          onSelected: (value) {
                                            if (value == 'edit') {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddPostScreen(
                                                    isUpdate: true,
                                                    posts: currentPost,
                                                  ),
                                                ),
                                              );
                                            } else if (value == 'delete') {
                                              p_value.deleteHome_Post(
                                                  currentPost.id!, context);
                                            }
                                          },
                                        )
                                      : const SizedBox(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          currentPost.createdAt !=
                                                  currentPost.updatedAt
                                              ? "Edited : " + editedTimestamp
                                              : "",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    double imageSize = constraints.maxWidth;

                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ClipRRect(
                                            child: ColorFiltered(
                                              colorFilter: const ColorFilter.mode(
                                                Colors.grey,
                                                BlendMode.saturation,
                                              ),
                                              child: Image.network(
                                                "http://192.168.0.106/Flutter-BlogApp-Backend/public/postedimage/${p_value.postModel[index].image!}",
                                                fit: BoxFit.cover,
                                                height: imageSize,
                                                width: imageSize,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                          child: Text(
                                            p_value.postModel[index].body!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Selector<PostProvider, int>(
                                      selector: (context, postProvider) =>
                                          postProvider
                                              .postModel[index].likesCount ??
                                          0,
                                      builder: (context, likesCount, child) {
                                        return Row(
                                          children: [
                                            kLikeAndComment(
                                              likesCount,
                                              p_value.postModel[index]
                                                          .selfLike ==
                                                      true
                                                  ? Icons.thumb_up
                                                  : Icons.thumb_up_alt_outlined,
                                              p_value.postModel[index]
                                                          .selfLike ==
                                                      true
                                                  ? Colors.black
                                                  : Colors.grey,
                                              () {
                                                PostProvider postProvider =
                                                    Provider.of<PostProvider>(
                                                  context,
                                                  listen: false,
                                                );
                                                postProvider.likeUnlikepost(
                                                  p_value.postModel[index].id!,
                                                  context,
                                                );
                                              },
                                            ),
                                            const SizedBox(width: 10),
                                            kLikeAndComment(
                                              p_value.postModel[index]
                                                      .commentsCount ??
                                                  0,
                                              Icons.textsms,
                                              Colors.black,
                                              () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CommentScreen(
                                                      postId: p_value
                                                          .postModel[index].id,
                                                      commentcount: p_value
                                                          .postModel[index]
                                                          .commentsCount,
                                                      image:   p_value.postModel[index].user?.propic ?? 'assets/images/propic.JPG',
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    )),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
