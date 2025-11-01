class Message {
  Notification? notification;

  Message({this.notification});

  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(notification: Notification.fromJson(json["notification"]));

  Map<String, dynamic> toJson() => {"notification": notification?.toJson()};
}

class Notification {
  String? body;
  String? title;

  Notification({this.body, this.title});

  factory Notification.fromJson(Map<String, dynamic> json) =>
      Notification(body: json["body"], title: json["title"]);

  Map<String, dynamic> toJson() => {"body": body, "title": title};
}
