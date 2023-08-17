/// 文件上传状态
enum UploadStateEnum {
  uploading(desc: '上传中'),
  success(desc: '上传成功'),
  fail(desc: '上传失败');

  const UploadStateEnum({required String desc});
}
