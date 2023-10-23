import 'package:blogapp/model/sentfnd_request.dart';
import 'package:blogapp/provider/friendlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class SentRequestScreen extends StatefulWidget {
  const SentRequestScreen({super.key});

  @override
  State<SentRequestScreen> createState() => _SentRequestScreenState();
}

class _SentRequestScreenState extends State<SentRequestScreen> {
  @override
  Widget build(BuildContext context) {
    String formattedTimestamp = '';
    FriendListProvider friendListProviders =
        Provider.of<FriendListProvider>(context, listen: false);
    friendListProviders.getSentFriendRequest(context);
    return Scaffold(
  
        body: Consumer<FriendListProvider>(
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: friendListProviders.sentRequestList.length,
          itemBuilder: (context, index) {
            SentRequests sentrRequest = value.sentRequestList[index];

            final DateTime parsedDateTime =
                DateTime.parse(sentrRequest.createdAt!);
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
                      child: sentrRequest.recipient!.propic != null
                          ? FadeInImage.assetNetwork(
                              placeholder:
                                  'assets/images/propic.JPG', // Provide the path to your placeholder image asset
                              image:
                                  "http://192.168.0.106/Flutter-BlogApp-Backend/public/profile-pictures/${sentrRequest.recipient!.propic!}",
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
                title: Text(sentrRequest.recipient!.name!.toString(),
                    style: TextStyle(color: Colors.white)),
                subtitle: Text("Sent  " + formattedTimestamp,
                    style: TextStyle(color: Colors.grey)),
                trailing: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm Deletion'),
                          content: Text('Are you sure to delete this friend?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('No',
                                  style: TextStyle(color: Colors.black)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Yes',
                                  style: TextStyle(color: Colors.black)),
                              onPressed: () {
                        
                                friendListProviders.cancleSentRequest(
                                    sentrRequest.requestId!, context);
                                Navigator.of(context).pop();
                                
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
        );
      },
    ));
  }
}
