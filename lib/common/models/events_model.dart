class EventsModel {
  String id;
  String username;
  String avatarUrl;

  EventsModel({
    required this.id,
    required this.username,
    required this.avatarUrl,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
        id: json["id"],
        username: json["actor"]["login"],
        avatarUrl: json["actor"]["avatar_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "avatarUrl": avatarUrl,
      };
}
