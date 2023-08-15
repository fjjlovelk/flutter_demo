import 'package:flutter/material.dart';
import 'package:flutter_demo/common/models/file_model.dart';
import 'package:flutter_demo/common/utils/loading.dart';
import 'package:flutter_demo/common/widgets/image_select.dart';
import 'package:flutter_demo/common/widgets/image_upload_item.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  final List<FileModel>? items;

  /// 数量限制
  final int countLimit;

  /// 大小限制，单位：MB
  final int sizeLimit;

  final void Function(List<FileModel>) onChange;

  const ImageUpload({
    Key? key,
    this.countLimit = 5,
    this.sizeLimit = 2,
    required this.onChange,
    this.items,
  }) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  /// 文件列表
  List<FileModel> _fileList = [];

  @override
  void initState() {
    if (widget.items != null) {
      _fileList =
          widget.items!.map((e) => FileModel.fromJson(e.toJson())).toList();
    }
    super.initState();
  }

  /// 选择照片/拍照 触发事件
  void onChange(List<XFile> file) {
    if (_fileList.length + file.length > widget.countLimit) {
      Loading.showInfo('最多只能选择${widget.countLimit}张图片');
      return;
    }
    for (var item in file) {
      final fileModel = FileModel(data: item);
      _fileList.add(fileModel);
    }
    widget.onChange.call(_fileList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ..._fileList
            .map(
              (e) => ImageUploadItem(
                key: ObjectKey(e),
                path: e.data?.path,
                url: e.filepath,
                onSuccess: (f) {
                  e.filepath = f['filepath'];
                  e.filename = f['filename'];
                  widget.onChange.call(_fileList);
                },
                onError: () {
                  _fileList.remove(e);
                  widget.onChange.call(_fileList);
                  setState(() {});
                },
                onLongPress: () {
                  _fileList.remove(e);
                  widget.onChange.call(_fileList);
                  setState(() {});
                },
              ),
            )
            .toList(),
        if (widget.countLimit != -1 && _fileList.length < widget.countLimit)
          ImageSelect(
            countLimit: widget.countLimit,
            onChange: onChange,
          ),
      ],
    );
  }
}
