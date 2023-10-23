class LikedRecived {
  List<ReceivedLikes>? receivedLikes;

  LikedRecived({this.receivedLikes});

  LikedRecived.fromJson(Map<String, dynamic> json) {
    if (json['receivedLikes'] != null) {
      receivedLikes = <ReceivedLikes>[];
      json['receivedLikes'].forEach((v) {
        receivedLikes!.add(new ReceivedLikes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.receivedLikes != null) {
      data['receivedLikes'] =
          this.receivedLikes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReceivedLikes {
  int? id;
  int? userId;
  int? postId;
  String? createdAt;
  String? updatedAt;

  ReceivedLikes(
      {this.id, this.userId, this.postId, this.createdAt, this.updatedAt});

  ReceivedLikes.fromJson(Map<String, dynamic> json) {
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