// 文件信息
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

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
