class FriendsPost {
  List<FriendPosts>? friendPosts;

  FriendsPost({this.friendPosts});

  FriendsPost.fromJson(Map<String, dynamic> json) {
    if (json['friend_posts'] != null) {
      friendPosts = <FriendPosts>[];
      json['friend_posts'].forEach((v) {
        friendPosts!.add(new FriendPosts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.friendPosts != null) {
      data['friend_posts'] = this.friendPosts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FriendPosts {
  int? id;
  int? userId;
  String? body;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? commentsCount;
  int? likesCount;
  bool? selfLike;
  User? user;
  List<Comments>? comments;
  List<Likes>? likes;

  FriendPosts(
      {this.id,
      this.userId,
      this.body,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.commentsCount,
      this.likesCount,
      this.selfLike,
      this.user,
      this.comments,
      this.likes});

  FriendPosts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    body = json['body'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    commentsCount = json['commentsCount'];
    likesCount = json['likesCount'];
    selfLike = json['selfLike'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(new Likes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['body'] = this.body;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['commentsCount'] = this.commentsCount;
    data['likesCount'] = this.likesCount;
    data['selfLike'] = this.selfLike;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? propic;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.propic});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    propic = json['propic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['propic'] = this.propic;
    return data;
  }
}

class Comments {
  int? id;
  int? userId;
  int? postId;
  String? comment;
  String? createdAt;
  String? updatedAt;
  User? user;

  Comments(
      {this.id,
      this.userId,
      this.postId,
      this.comment,
      this.createdAt,
      this.updatedAt,
      this.user});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Likes {
  int? id;
  int? userId;
  int? postId;
  String? createdAt;
  String? updatedAt;
  User? user;

  Likes(
      {this.id,
      this.userId,
      this.postId,
      this.createdAt,
      this.updatedAt,
      this.user});

  Likes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
