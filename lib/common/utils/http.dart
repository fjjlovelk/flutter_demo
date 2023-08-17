import 'package:dio/dio.dart';
import 'package:flutter_demo/common/config/http_config.dart';
import 'package:flutter_demo/common/store/user.dart';
import 'package:flutter_demo/common/utils/loading.dart';
import 'package:get/get.dart' as getx;

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  late Dio dio;

  CancelToken cancelToken = CancelToken();

  HttpUtil._internal() {
    // 初始化
    BaseOptions options = BaseOptions(
      baseUrl: HttpConfig.baseUrl,
      connectTimeout: HttpConfig.connectTimeout,
      receiveTimeout: HttpConfig.receiveTimeout,
    );
    dio = Dio(options);
    // 自定义拦截器
    dio.interceptors.add(InterceptorsWrapper(
      // 请求拦截
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        if (getx.Get.isRegistered<UserStore>() && UserStore.to.hasToken) {
          options.headers['X-Access-Token'] = UserStore.to.token;
        }
        return handler.next(options);
      },
      // 响应拦截
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        return handler.next(response);
      },
      // 错误拦截
      onError: (DioException e, ErrorInterceptorHandler handler) {
        onError(e);
        return handler.next(e);
      },
    ));
  }

  /// 错误处理
  void onError(DioException err) {
    print('onError---${err.toString()}');
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        Loading.showError('连接超时');
        break;
      case DioExceptionType.sendTimeout:
        Loading.showError('请求超时');
        break;
      case DioExceptionType.receiveTimeout:
        Loading.showError('响应超时');
        break;
      case DioExceptionType.badCertificate:
        Loading.showError('证书错误');
        break;
      case DioExceptionType.connectionError:
        Loading.showError('连接错误');
        break;
      case DioExceptionType.unknown:
        // 当err.type为unknown时err.error通常不为null
        Loading.showError(err.error?.toString() ?? '未知错误');
        break;
      case DioExceptionType.badResponse:
        Loading.showError(err.message ?? '服务器错误');
        break;
      default:
        break;
    }
  }

  /// 取消请求
  void cancelRequest() {
    cancelToken.cancel('cancelled');
  }

  /// get方法
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: requestOptions,
    );
    return response.data;
  }

  /// post方法
  Future post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: requestOptions,
    );
    return response.data;
  }

  /// put方法
  Future put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: requestOptions,
    );
    return response.data;
  }

  /// patch方法
  Future patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: requestOptions,
    );
    return response.data;
  }

  /// delete方法
  Future delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: requestOptions,
    );
    return response.data;
  }

  /// restful post form 表单提交操作
  Future postForm(
    String path, {
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.post(
      path,
      data: FormData.fromMap(data),
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: requestOptions,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return response.data;
  }
}
