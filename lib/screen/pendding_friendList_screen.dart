import 'package:blogapp/provider/friendlist_provider.dart';
import 'package:blogapp/screen/search_friend_screen.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:blogapp/model/pendding_request.dart';

class PenddingFriendListScreen extends StatefulWidget {
  final List<PendingRequests> pendingFriendList;
  const PenddingFriendListScreen({
    Key? key,
    required this.pendingFriendList,
  }) : super(key: key);

  @override
  State<PenddingFriendListScreen> createState() =>
      _PenddingFriendListScreenState();
}

class _PenddingFriendListScreenState extends State<PenddingFriendListScreen> {
  String formattedTimestamp = '';
  FriendListProvider friendListProvider = FriendListProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Pending Friend Requests'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchFriendScreen(),
                ));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 5,
                    ),

                    // Navigate to search page
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SearchPage()),
                    // );

                    Text(
                      'Search Friends by Name or Email',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.pendingFriendList.length,
              itemBuilder: (context, index) {
                final DateTime parsedDateTime = DateTime.parse(
                    widget.pendingFriendList[index].sender!.createdAt!);
                final now = DateTime.now();
                final difference = now.difference(parsedDateTime);
                formattedTimestamp = timeago.format(now.subtract(difference));
                return Card(
                  color: Colors.black,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1542190891-2093d38760f2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80",
                      ),
                    ),
                    title: Text(
                      widget.pendingFriendList[index].sender!.name!.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "Received " + formattedTimestamp,
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.white70),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm Decline'),
                                  content: Text(
                                    'Are you sure you want to delete this friend request?',
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'No',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        friendListProvider.declineRequest(
                                          widget.pendingFriendList[index]
                                              .sender!.id!,
                                          context,
                                        );
                                        // Perform decline operation here
                                        // Assuming you have a declineFriendRequest function

                                        Navigator.of(context).pop();
                                        setState(() {
                                          widget.pendingFriendList
                                              .removeAt(index);
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.white),
                          onPressed: () {
                            friendListProvider.acceptRequest(
                              widget.pendingFriendList[index].sender!.id!,
                              context,
                            );
                            setState(() {
                              widget.pendingFriendList.removeAt(index);
                            });
                            // Perform accept operation here
                            // Assuming you have an acceptFriendRequest function
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
