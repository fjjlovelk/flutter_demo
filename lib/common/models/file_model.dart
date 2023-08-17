// 用户信息


class FileModel {
  String filepath;
  String filename;
  String assetPath;

  FileModel({
    this.filepath = "",
    this.filename = "",
    this.assetPath = "",
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        filepath: json["filepath"] ?? '',
        filename: json["filename"] ?? '',
        assetPath: json["assetPath"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "filepath": filepath,
        "filename": filename,
        "assetPath": assetPath,
      };
}
