import 'package:photo_manager/photo_manager.dart';

class FileModel {
  String filepath;
  String filename;
  AssetEntity? assetEntity;

  FileModel({
    this.filepath = "",
    this.filename = "",
    this.assetEntity,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        filepath: json["filepath"] ?? '',
        filename: json["filename"] ?? '',
        assetEntity: json["assetEntity"],
      );

  Map<String, dynamic> toJson() => {
        "filepath": filepath,
        "filename": filename,
        "assetEntity": assetEntity,
      };
}
