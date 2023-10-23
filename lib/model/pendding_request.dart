class PenddingRequest {
  List<PendingRequests>? pendingRequests;

  PenddingRequest({this.pendingRequests});

  PenddingRequest.fromJson(Map<String, dynamic> json) {
    if (json['pendingRequests'] != null) {
      pendingRequests = <PendingRequests>[];
      json['pendingRequests'].forEach((v) {
        pendingRequests!.add(PendingRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pendingRequests != null) {
      data['pendingRequests'] = pendingRequests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PendingRequests {
  int? id;
  Sender? sender;

  PendingRequests({this.id, this.sender});

  PendingRequests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = Sender.fromJson(json['sender']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    return data;
  }
}

class Sender {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  int? recipientId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Sender({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.recipientId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    recipientId = json['recipient_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['recipient_id'] = recipientId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}