import 'package:blogapp/model/post_model.dart';
import 'package:blogapp/provider/friendlist_provider.dart';
import 'package:blogapp/screen/add_post_screen.dart';
import 'package:blogapp/screen/friend_tabbar.dart';
 
import 'package:blogapp/screen/pendding_friendList_screen.dart';
import 'package:blogapp/screen/update_profile.dart';
import 'package:blogapp/utils/colorfilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
 

import 'package:blogapp/provider/auth_provider.dart';
import 'package:blogapp/provider/post_provider.dart';
import 'package:blogapp/screen/signin_screen.dart';
 
import 'package:timeago/timeago.dart' as timeago;

class ProfileScreen extends StatefulWidget {
  final int? userID;
  ProfileScreen({
    Key? key,
    this.userID,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
 
  ValueNotifier<String> postCountNotifier = ValueNotifier<String>('');
  ValueNotifier<String> recivedLikedCountNotifier = ValueNotifier<String>('');
  ValueNotifier<String> likedPostsCountNotifier = ValueNotifier<String>('');
  ValueNotifier<String> friendlistCount = ValueNotifier<String>('');
  ValueNotifier<String> pendingFriendlistCount = ValueNotifier<String>('');
  
  String formattedTimestamp = '';

  Future<bool> userLogout() async {
    await Provider.of<AuthProvider>(context, listen: false).userlogout();
    return true;
  }

  Future<void> _fetchUsersALlPosts() async {
    PostProvider postProvider =
        Provider.of<PostProvider>(context, listen: false);
    await postProvider.getUsersAllPosts(widget.userID, context);
    await postProvider.getRecivedLikes(widget.userID, context);
    await postProvider.getLikedPosts(widget.userID, context);
    postCountNotifier.value = postProvider.userAllPost.length.toString();
    recivedLikedCountNotifier.value =
        postProvider.recivedLikesList.length.toString();
    likedPostsCountNotifier.value =
        postProvider.likedPostsList.length.toString();

    print("Fetch user post called");
    print(postCountNotifier.value);
  }

  @override
  void initState() {
    super.initState();
    _fetchUsersALlPosts();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    await authProvider.getUserInfo(context);
  }

  FriendListProvider friendListProvider = FriendListProvider();

  void _fetchFriendInfo() async {
    await friendListProvider.getFriendlist(context);
    await friendListProvider.getPendingFriendlist(context);

    friendlistCount.value = friendListProvider.friendLists.length.toString();
    pendingFriendlistCount.value =
        friendListProvider.pendingFriendLists.length.toString();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).fetchUserName();

    _fetchFriendInfo();
    print("object");
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              title: Consumer<AuthProvider>(
                builder: (context, value, child) {
                  if (value.userName.isNotEmpty) {
                    return Text("Hey " + value.userName + " " + "!");
                  } else {
                    return Text("Loading.....");
                  }
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Log Out',
                  onPressed: () {
                    userLogout().then((value) => {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => SignIn()),
                              (route) => false)
                        });
                  },
                ),
              ]),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  color: Colors.black,
                  height: 120,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateProfile(userID: widget.userID),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 62,
                                  height: 62,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 10,
                                        spreadRadius: 5,
                                        // Adjust the offset based on your desired glow effect
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Consumer<AuthProvider>(
                                    builder: (context, authProvider, _) {
                                      if (authProvider.singleUser.isEmpty) {
                                        // User data not available yet, show a loading indicator or placeholder
                                        return CircularProgressIndicator();
                                      } else {
                                        String? propicUrl =
                                            authProvider.singleUser[0].propic;

                                        return CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 32,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 30,
                                            child: ClipOval(
                                              child: propicUrl != null
                                                  ? ColorFiltered(
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                        Colors.grey,
                                                        BlendMode.saturation,
                                                      ),
                                                      child: FadeInImage
                                                          .assetNetwork(
                                                        placeholder:
                                                            'assets/images/propic.JPG',
                                                        image: propicUrl
                                                                .isNotEmpty
                                                            ? "http://192.168.0.106/Flutter-BlogApp-Backend/public/profile-pictures/" +
                                                                propicUrl
                                                            : 'assets/images/propic.JPG',
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
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            // First column content
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            // Second column content
                            Text(
                              "Posts",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ValueListenableBuilder<String>(
                              valueListenable: postCountNotifier,
                              builder: (context, value, child) {
                                return Text(
                                  value,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                );
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FriendsTabBar(
                                    friendList: friendListProvider.friendLists,
                                  ),
                                ));
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "Friends",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ValueListenableBuilder<String>(
                                    valueListenable: friendlistCount,
                                    builder: (context, value, child) {
                                      return Text(
                                        value,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                      );
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            // Third column content
                            // Second column content
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Like Recived ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Like Given ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //Row for liked recived and given numbers
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ValueListenableBuilder<String>(
                                  valueListenable: recivedLikedCountNotifier,
                                  builder: (context, value, child) {
                                    return Text(
                                      value,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    );
                                  },
                                ),
                                ValueListenableBuilder<String>(
                                  valueListenable: likedPostsCountNotifier,
                                  builder: (context, value, child) {
                                    return Text(
                                      value,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    );
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      PenddingFriendListScreen(
                                          pendingFriendList: friendListProvider
                                              .pendingFriendLists),
                                ));
                              },
                              child: Column(
                                children: [
                                  const Text(
                                    "Pending Requests",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ValueListenableBuilder<String>(
                                    valueListenable: pendingFriendlistCount,
                                    builder: (context, value, child) {
                                      return Text(
                                        value,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                      );
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 3,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                        spreadRadius: 5,
                        // Adjust the offset based on your desired glow effect
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<PostProvider>(
                  builder: (context, value, child) {
                    return value.userAllPost.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.only(top: 205.0),
                            child: Text(
                              "Your friends are waiting for your post!!",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )
                        : AnimationLimiter(
                            child: Expanded(
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10.0,
                                  crossAxisSpacing: 10.0,
                            
                                ),
                                itemCount: value.userAllPost.length,
                                itemBuilder: (context, index) {
                                  Posts currentPost = value.userAllPost[index];

                                  if (currentPost.createdAt != null) {
                                    final DateTime parsedDateTime =
                                        DateTime.parse(currentPost.createdAt!);
                                    final now = DateTime.now();
                                    final difference =
                                        now.difference(parsedDateTime);
                                    formattedTimestamp = timeago
                                        .format(now.subtract(difference));
                                  } else {
                                    print(currentPost.createdAt);
                                  }
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: const Duration(milliseconds: 300),
                                    columnCount: 2,
                                    child: ScaleAnimation(
                                      // curve: Curves.fastLinearToSlowEaseIn,
                                      child: FadeInAnimation(
                                        child: InkWell(
                                          onTap: () {
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
                                                                value.deletePost(
                                                                    value
                                                                        .userAllPost[
                                                                            index]
                                                                        .id!,
                                                                    context);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                );
                                              },
                                            );
                                          },
                                          child: Card(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: ColorFiltered(
                                                    colorFilter:
                                                        ColorFilters.greyscale,
                                                    child: Image.network(
                                                      "http://192.168.0.106/Flutter-BlogApp-Backend/public/postedimage/${value.userAllPost[index].image!}",
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        value.userAllPost[index]
                                                            .body!,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4),
                                                      Text(
                                                        formattedTimestamp,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return AddPostScreen(isUpdate: false);
                },
              ));
            },
            icon: Icon(Icons.add),
            label: Text('Add Post'),
          )),
    );
  }
}
