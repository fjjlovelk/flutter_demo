// 用户信息
class UserModel {
  String? id;
  String? username;
  String? accessToken;

  UserModel({
    this.id,
    this.username,
    this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "accessToken": accessToken,
      };
}
