import 'package:blogapp/model/searchuser_model.dart';
import 'package:blogapp/provider/friendlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchFriendScreen extends StatefulWidget {
  const SearchFriendScreen({super.key});

  @override
  State<SearchFriendScreen> createState() => _SearchFriendScreenState();
}

class _SearchFriendScreenState extends State<SearchFriendScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  void _searchFriends(BuildContext context) {
    final provider = Provider.of<FriendListProvider>(context, listen: false);
    String query = _searchController.text;
    provider.clearSearchedFriends();
    provider.getSearchedFriendlist(query, context);
  }

  @override
  Widget build(BuildContext context) {
    FriendListProvider friendListProvider = FriendListProvider();
    return WillPopScope(
      onWillPop: () async {
        Provider.of<FriendListProvider>(context, listen: false)
            .clearSearchedFriends();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Search Friends'),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search friends...',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            // Clear the search results here if desired
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _searchFriends(context);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<FriendListProvider>(
                builder: (context, provider, _) {
                  List<Users> searchedFriends = provider.searchedFriends;
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    itemCount: searchedFriends.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      Users friend = searchedFriends[index];
                      return Card(
                        color: Colors.black,
                        elevation: 2.0,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 25,
                            child: ClipOval(
                              child: searchedFriends[index].propic != null
                                  ? ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        Colors.grey,
                                        BlendMode.saturation,
                                      ),
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            'assets/images/propic.JPG', // Provide the path to your placeholder image asset
                                        image:
                                            "http://192.168.0.106/Flutter-BlogApp-Backend/public/profile-pictures/${friend.propic}",
                                        fit: BoxFit.cover,

                                        width: 80,
                                        height: 80,
                                      ),
                                    )
                                  : Image.asset(
                                      'assets/images/propic.JPG', // Provide the path to your placeholder image asset
                                      fit: BoxFit.cover,
                                      width: 80,
                                      height: 80,
                                    ),
                            ),
                          ),
                          title: Text(
                            friend.name!,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              friendListProvider.sendRequest(
                                  friend.id!, context);
                            },
                            icon: Icon(
                              Icons.person_add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
