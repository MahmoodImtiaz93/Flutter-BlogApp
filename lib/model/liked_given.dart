class LikedGiven {
  List<LikedPosts>? likedPosts;

  LikedGiven({this.likedPosts});

  LikedGiven.fromJson(Map<String, dynamic> json) {
    if (json['likedPosts'] != null) {
      likedPosts = <LikedPosts>[];
      json['likedPosts'].forEach((v) {
        likedPosts!.add(new LikedPosts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.likedPosts != null) {
      data['likedPosts'] = this.likedPosts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LikedPosts {
  int? id;
  int? userId;
  String? body;
  String? image;
  String? createdAt;
  String? updatedAt;

  LikedPosts(
      {this.id,
      this.userId,
      this.body,
      this.image,
      this.createdAt,
      this.updatedAt});

  LikedPosts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    body = json['body'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['body'] = this.body;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}