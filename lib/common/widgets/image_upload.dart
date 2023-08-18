import 'package:flutter/material.dart';
import 'package:flutter_demo/common/models/file_model.dart';
import 'package:flutter_demo/common/utils/loading.dart';
import 'package:flutter_demo/common/widgets/image_select.dart';
import 'package:flutter_demo/common/widgets/image_upload_item.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImageUpload extends StatefulWidget {
  final List<FileModel>? items;

  /// 每行个数
  final int rowCount;

  /// 间隔
  final double spacing;

  /// 数量限制
  final int countLimit;

  /// 大小限制，单位：MB
  final int sizeLimit;

  final void Function(List<FileModel>) onChange;

  const ImageUpload({
    Key? key,
    this.rowCount = 4,
    this.spacing = 8,
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
    print('items----${widget.items}');
    if (widget.items != null) {
      _fileList =
          widget.items!.map((e) => FileModel.fromJson(e.toJson())).toList();
    }
    super.initState();
  }

  /// 选择照片/拍照 触发事件
  void onChange(List<AssetEntity> file) {
    if (_fileList.length + file.length > widget.countLimit) {
      Loading.showInfo('最多只能选择${widget.countLimit}张图片');
      return;
    }
    for (var item in file) {
      final fileModel = FileModel(assetEntity: item);
      _fileList.add(fileModel);
    }
    widget.onChange.call(_fileList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(widget.spacing),
      child: LayoutBuilder(
        builder: (_, constraints) {
          final itemWidth =
              ((constraints.maxWidth - widget.spacing * (widget.rowCount - 1)) /
                  widget.rowCount);
          return Wrap(
            spacing: widget.spacing,
            runSpacing: widget.spacing,
            children: [
              ..._fileList
                  .map(
                    (e) => ImageUploadItem(
                      // 加入ObjectKey，保证已有的组件不重新刷新
                      key: ObjectKey(e),
                      assetEntity: e.assetEntity,
                      url: e.filepath,
                      boxSize: itemWidth,
                      onSuccess: (f) {
                        e.filepath = f.filepath;
                        e.filename = f.filename;
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
              if (widget.countLimit != -1 &&
                  _fileList.length < widget.countLimit)
                ImageSelect(
                  boxSize: itemWidth,
                  countLimit: widget.countLimit,
                  selectedCount: _fileList.length,
                  onChange: onChange,
                ),
            ],
          );
        },
      ),
    );
  }
}
