class SentFndRequest {
  List<SentRequests>? sentRequests;

  SentFndRequest({this.sentRequests});

  SentFndRequest.fromJson(Map<String, dynamic> json) {
    if (json['sentRequests'] != null) {
      sentRequests = <SentRequests>[];
      json['sentRequests'].forEach((v) {
        sentRequests!.add(new SentRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sentRequests != null) {
      data['sentRequests'] = this.sentRequests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SentRequests {
  int? requestId;
  Recipient? recipient;
  String? status;
  String? createdAt;
  String? updatedAt;

  SentRequests(
      {this.requestId,
      this.recipient,
      this.status,
      this.createdAt,
      this.updatedAt});

  SentRequests.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    recipient = json['recipient'] != null
        ? new Recipient.fromJson(json['recipient'])
        : null;
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    if (this.recipient != null) {
      data['recipient'] = this.recipient!.toJson();
    }
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Recipient {
  int? id;
  String? name;
  String? email;
  String? propic;

  Recipient({this.id, this.name, this.email, this.propic});

  Recipient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    propic = json['propic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['propic'] = this.propic;
    return data;
  }
}