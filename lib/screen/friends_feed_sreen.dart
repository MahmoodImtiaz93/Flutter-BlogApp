import 'package:blogapp/model/friends_post.dart';
 
import 'package:blogapp/provider/post_provider.dart';
 
import 'package:blogapp/screen/comment_screen.dart';
import 'package:blogapp/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class FriendsFeed extends StatefulWidget {
  const FriendsFeed({super.key});

  @override
  State<FriendsFeed> createState() => _FriendsFeedState();
}

class _FriendsFeedState extends State<FriendsFeed> {
  int userID = 0;
  String formattedTimestamp = '';
  String editedTimestamp = '';

 
  @override
  Widget build(BuildContext context) {
    PostProvider postProvider =
        Provider.of<PostProvider>(context, listen: false);
    postProvider.getfriendsPosts(context);

    postProvider.savedUserInfo().then((String? userInfo) {
      userID = int.parse(userInfo!);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("From Friends"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: Colors.black,
          onRefresh: () {
            return postProvider.getfriendsPosts(context);
          },
          child: Consumer<PostProvider>(
            builder: (context, value, child) {
              return value.friendspostList.length == 0
                  ? const Center(
                      child: Text(
                      "No Updates from Friends.",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ))
                  : ListView.builder(
                      itemCount: value.friendspostList.length,
                      itemBuilder: (context, index) {
                        FriendPosts currentPost = value.friendspostList[index];

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
                                      EdgeInsets.symmetric(horizontal: 10),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 28,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 25,
                                      child: ClipOval(
                                        child: value.friendspostList[index]
                                                    .user!.propic !=
                                                null
                                            ? FadeInImage.assetNetwork(
                                                placeholder:
                                                    'assets/images/propic.JPG', // Provide the path to your placeholder image asset
                                                image:
                                                    "http://192.168.0.106/Flutter-BlogApp-Backend/public/profile-pictures/${value.friendspostList[index].user!.propic!}",
                                                fit: BoxFit.cover,

                                                width: 80,
                                                height: 80,
                                              )
                                            : Image.asset(
                                                'assets/images/propic.JPG', // Provide the path to your placeholder image asset
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
                                            } else {
                                              // Handle delete
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
                                                "http://192.168.0.106/Flutter-BlogApp-Backend/public/postedimage/${value.friendspostList[index].image!}",
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
                                            value.friendspostList[index].body!,
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
                                  child: Row(
                                    children: [
                                      kLikeAndComment(
                                        value.friendspostList[index]
                                                .likesCount ??
                                            0,
                                        value.friendspostList[index].selfLike ==
                                                true
                                            ? Icons.thumb_up
                                            : Icons.thumb_up_alt_outlined,
                                        value.friendspostList[index].selfLike ==
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
                                            value.friendspostList[index].id!,
                                            context,
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 10),
                                      kLikeAndComment(
                                        value.friendspostList[index]
                                                .commentsCount ??
                                            0,
                                        Icons.textsms,
                                        Colors.black,
                                        () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CommentScreen(
                                                postId: value
                                                    .friendspostList[index].id,
                                                commentcount: value
                                                    .friendspostList[index]
                                                    .commentsCount,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
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
