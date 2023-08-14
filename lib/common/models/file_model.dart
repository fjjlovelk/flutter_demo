// 用户信息
import 'package:image_picker/image_picker.dart';

class FileModel {
  String? filepath;
  String? filename;
  XFile? data;

  FileModel({
    this.filepath = "",
    this.filename = "",
    this.data,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        filepath: json["filepath"] ?? '',
        filename: json["filename"] ?? '',
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "filepath": filepath,
        "filename": filename,
      };
}
