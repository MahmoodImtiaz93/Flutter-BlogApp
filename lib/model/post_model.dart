import 'dart:convert';

import 'package:blogapp/model/user_model.dart';

 

class Post {
  List<Posts>? posts;

  Post({this.posts});

  Post.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
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
  List<Commentss>? comments;
  List<Likes>? likes;

  Posts(
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

  Posts.fromJson(Map<String, dynamic> json) {
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
      comments = <Commentss>[];
      json['comments'].forEach((v) {
        comments!.add(new Commentss.fromJson(v));
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

class Commentss {
  int? id;
  int? userId;
  int? postId;
  String? comment;
  String? createdAt;
  String? updatedAt;

  Commentss(
      {this.id,
      this.userId,
      this.postId,
      this.comment,
      this.createdAt,
      this.updatedAt});

  Commentss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Likes {
  int? id;
  int? userId;
  int? postId;
  String? createdAt;
  String? updatedAt;

  Likes({this.id, this.userId, this.postId, this.createdAt, this.updatedAt});

  Likes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_id'] = this.postId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
