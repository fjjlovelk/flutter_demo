// 用户信息
class UserInfoModel {
  String? id;
  String? username;
  String? accessToken;

  UserInfoModel({
    this.id,
    this.username,
    this.accessToken,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
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
