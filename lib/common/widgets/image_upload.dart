import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/models/file_model.dart';
import 'package:flutter_demo/common/utils/loading_util.dart';
import 'package:flutter_demo/common/widgets/image_select.dart';
import 'package:flutter_demo/common/widgets/image_upload_item.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImageUploadController extends ChangeNotifier {
  List<FileModel> _list = [];

  List<FileModel> get list => _list;

  void remove(FileModel e) {
    _list.remove(e);
    notifyListeners();
  }

  void removeAt(int index) {
    if (index > _list.length || index < 0) {
      throw (StateError("index is invalid"));
    }
    _list.removeAt(index);
    notifyListeners();
  }

  void removeAll(List<FileModel> l) {
    _list = [];
    notifyListeners();
  }

  void add(FileModel e) {
    _list.add(e);
    notifyListeners();
  }

  void addAll(List<FileModel> l) {
    _list.addAll(l);
    notifyListeners();
  }

  void change(int index, FileModel e) {
    if (index > _list.length || index < 0) {
      throw (StateError("index is invalid"));
    }
    _list[index].filename = e.filename;
    _list[index].filepath = e.filepath;
    notifyListeners();
  }

  @override
  String toString() {
    return _list
        .map((e) =>
            "filename：${e.filename};filepath：${e.filepath};assetEntity：${e.assetEntity == null}")
        .join('---');
  }
}

class ImageUpload extends StatelessWidget {
  /// ImageUploadController，用来控制与获取文件列表
  final ImageUploadController controller;

  final void Function(List<FileModel>)? onChange;

  /// 每行个数
  final int rowCount;

  /// 间隔
  final double spacing;

  /// 数量限制
  final int countLimit;

  /// 大小限制，单位：MB
  final int sizeLimit;

  const ImageUpload({
    Key? key,
    this.rowCount = 4,
    this.spacing = 8,
    this.countLimit = 5,
    this.sizeLimit = 1,
    required this.controller,
    this.onChange,
  }) : super(key: key);

  /// 选择照片/拍照 触发事件
  void imageChange(List<AssetEntity> file) {
    if (controller.list.length + file.length > countLimit) {
      LoadingUtil.showInfo('最多只能选择$countLimit张图片');
      return;
    }
    final List<FileModel> list =
        file.map((e) => FileModel(assetEntity: e)).toList();
    controller.addAll(list);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (BuildContext context, Widget? child) {
        onChange?.call(controller.list);
        final noPlusIcon =
            countLimit != -1 && controller.list.length == countLimit;
        return GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(spacing),
          itemCount: controller.list.length + (noPlusIcon ? 0 : 1),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: rowCount,
            mainAxisSpacing: spacing,
            crossAxisSpacing: spacing,
          ),
          itemBuilder: (_, index) {
            if (!noPlusIcon && index == controller.list.length) {
              return ImageSelect(
                countLimit: countLimit,
                selectedCount: controller.list.length,
                onChange: imageChange,
              );
            }
            final e = controller.list[index];
            return ImageUploadItem(
              key: ValueKey<String>(e.filepath.isNotEmpty
                  ? e.filepath
                  : (e.assetEntity?.id ?? '')),
              assetEntity: e.assetEntity,
              url: e.filepath,
              sizeLimit: sizeLimit,
              onSuccess: (f) {
                controller.change(index, f);
              },
              onError: () {
                controller.remove(e);
              },
              onLongPress: (CancelToken cancelToken) {
                cancelToken.cancel();
                controller.remove(e);
              },
            );
          },
        );
      },
    );
  }
}
