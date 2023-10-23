import 'package:blogapp/provider/friendlist_provider.dart';
import 'package:flutter/material.dart';

import 'package:blogapp/model/friendlist_model.dart';
 
import 'package:timeago/timeago.dart' as timeago;

class FriendListScreen extends StatefulWidget {
  final List<Friends> friendList;

  FriendListScreen({
    Key? key,
    required this.friendList,
  }) : super(key: key);

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  String formattedTimestamp = '';
  FriendListProvider friendListProvider = FriendListProvider();

   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      body: ListView.builder(
        itemCount: widget.friendList.length,
        itemBuilder: (context, index) {
          Friends friend = widget.friendList[index];
          final DateTime parsedDateTime = DateTime.parse(friend.updatedAt!);
          final now = DateTime.now();
          final difference = now.difference(parsedDateTime);
          formattedTimestamp = timeago.format(now.subtract(difference));
          return Card(
            color: Colors.black,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 28,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: ClipOval(
                    child: friend.propic != null
                        ? FadeInImage.assetNetwork(
                            placeholder:
                                'assets/images/propic.JPG', // Provide the path to your placeholder image asset
                            image:
                                "http://192.168.0.106/Flutter-BlogApp-Backend/public/profile-pictures/${friend.propic!}",
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
              title: Text(friend.name.toString(),
                  style: const TextStyle(color: Colors.white)),
              subtitle: Text("Added: " + formattedTimestamp,
                  style: TextStyle(color: Colors.grey)),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Deletion'),
                        content: const Text('Are you sure to delete this friend?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('No',
                                style: TextStyle(color: Colors.black)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Yes',
                                style: TextStyle(color: Colors.black)),
                            onPressed: () {
                       
                              friendListProvider.deleteFriend(
                                  friend.id!, context);
                              Navigator.of(context).pop();
                              setState(() {
                                widget.friendList.removeAt(index);
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
