import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grock/grock.dart';

/// With this data type, you can determine the method types of your API requests.
enum GrockDioType { get, post, put, delete, patch }

class GrockDioLogger {
  final bool responseBody;
  final bool request;
  final bool requestHeader;
  final bool responseHeader;
  final bool error;
  final bool requestBody;

  /// default all value false
  const GrockDioLogger.off()
      : responseBody = false,
        request = false,
        requestHeader = false,
        responseHeader = false,
        error = false,
        requestBody = false;

  /// default all value true
  const GrockDioLogger.on()
      : responseBody = true,
        request = true,
        requestHeader = true,
        responseHeader = true,
        error = true,
        requestBody = true;

  /// default values
  const GrockDioLogger.defaultValues()
      : responseBody = false,
        request = true,
        requestHeader = true,
        responseHeader = true,
        error = true,
        requestBody = false;
}

/// 😎😎😎😎😎😎 Grock package Dio Services 😎😎😎😎😎😎
/// * With this class, you will be able to perform Restfull Api
/// service operations more easily by using the dio package.
/// * You can use it in your project by adding it to your pubspec.yaml file.
/// Usefull Extensions
/// -----------------
/// ```dart
/// 
/// import 'package:grock/grock.dart';
/// 
/// void main() {
///   GrockDioServices.instance.init(
///     baseUrl: 'https://jsonplaceholder.typicode.com',
///     connectTimeout: 5000,
///     receiveTimeout: 3000,
///     logger = GrockDioLogger.default(),
///     setAuthorizationToken: () async {
///       final tokenValue = await getToken();
///       final mapData = {"Authorization": "Bearer $tokenValue"};
///       return mapData;
///     },
///   );
///   runApp(MyApp());
/// }
/// ```
class GrockDioServices {
  GrockDioServices._internal();

  static final GrockDioServices _instance = GrockDioServices._internal();

  static GrockDioServices get instance => _instance;

  static late Dio _dio;

  /// main.dart initialize BaseOptions
  ///
  /// ```dart
  /// void main() {
  ///   GrockDioServices.instance.init(
  ///     baseUrl: 'https://jsonplaceholder.typicode.com',
  ///     connectTimeout: 5000,
  ///     receiveTimeout: 3000,
  ///     logger = GrockDioLogger.default(),
  ///     setAuthorizationToken: () async {
  ///       final tokenValue = await getToken();
  ///       final mapData = {"Authorization": "Bearer $tokenValue"};
  ///       return mapData;
  ///     },
  ///   );
  ///   runApp(MyApp());
  /// }
  /// ```
  ///
  /// and use Api Request
  /// ----------------- request example -----------------
  /// ```dart
  /// final request = await GrockDioServices.request(
  ///  method: GrockDioType.get,
  ///  path: '/posts',
  ///  queryParameters: {"userId": 1},
  /// ).grockResponseHandler(
  ///   success: (response) => Model.fromJson(response.data),
  ///   error: (err) => Toast.show(err.toString()),
  ///   loading: () => print("loading"),
  ///   done: () => print("done"),
  /// );
  /// ```
  ///
  Future<void> init({
    /// optionally you can add your own Dio
    Dio? dio,

    /// added required String baseUrl,
    required String baseUrl,

    /// added milliseconds
    int? connectTimeout,

    /// added milliseconds
    int? receiveTimeout,

    /// added headers
    Map<String, dynamic>? headers,

    /// added queryParameters
    Map<String, dynamic>? queryParameters,

    /// optionally you can add your own BaseOptions
    Options? request,

    /// async get token and headers add token
    /// ```dart
    /// void main() async {
    ///  WidgetsFlutterBinding.ensureInitialized();
    ///  await GrockDioServices.instance.init(
    ///   baseUrl: 'https://jsonplaceholder.typicode.com',
    ///   setAuthorizationToken: () async {
    ///     final tokenValue = await getToken();
    ///     final mapData = {"Authorization": "Bearer $tokenValue"};
    ///     return mapData;
    ///   },
    /// );
    /// runApp(MyApp());
    /// ```
    Future<Map<String, dynamic>?> Function()? setAuthorizationToken,

    /// or set BaseOptions
    BaseOptions? options,

    /// Optionally you can add logger
    GrockDioLogger? logger,
  }) async {
    if (setAuthorizationToken != null) {
      final token = await setAuthorizationToken();
      if (token != null) {
        (headers ??= {}).addAll(token);
      }
    }
    _dio = dio ??
        Dio(
          options ??
              BaseOptions(
                baseUrl: baseUrl,
                connectTimeout: connectTimeout?.milliseconds,
                receiveTimeout: receiveTimeout?.milliseconds,
                headers: headers,
                queryParameters: queryParameters,
                responseType: ResponseType.json,
                contentType: Headers.jsonContentType,
                validateStatus: (status) => status! < 500,
              ),
        );
    
    if (logger != null) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: logger.requestBody,
          request: logger.request,
          requestHeader: logger.requestHeader,
          responseHeader: logger.responseHeader,
          error: logger.error,
          requestBody: logger.requestBody));
    }
  }

  /// ----------------- request example -----------------
  /// ```dart
  /// final request = await GrockDioServices.request(
  ///  method: GrockDioType.get,
  ///  path: '/posts',
  ///  queryParameters: {"userId": 1},
  ///  isLogger: true,
  /// ).grockResponseHandler(
  ///   success: (response) => Model.fromJson(response.data),
  ///   error: (err) => Toast.show(err.toString()),
  ///   loading: () => print("loading"),
  ///   done: () => print("done"),
  /// );
  /// ```
  ///
  static Future<Response> request({
    GrockDioType method = GrockDioType.get,
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
  }) async {
    try {
      final dio = _dio;
      final result = switch (method) {
        GrockDioType.get => dio.get,
        GrockDioType.post => dio.post,
        GrockDioType.put => dio.put,
        GrockDioType.delete => dio.delete,
        GrockDioType.patch => dio.patch,
      };
      return await result(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      return e.response!;
    } catch (e) {
      rethrow;
    }
  }
}

extension DioExtension on Future<Response> {

  /// ----------------- grockResponseHandler example -----------------
  /// ```dart
  /// final response = await GrockDioServices.request().grockResponseHandler(
  ///  success: (response) => Model.fromJson(response.data),
  ///  error: (err) => Toast.show(err.toString()),
  ///  loading: () => print("loading"),
  ///  done: () => print("done"),
  /// );
  Future<T?> grockResponseHandler<T>(
      {T Function(Response response)? success,
      void Function(dynamic err)? error,
      void Function()? loading,
      void Function()? done}) async {
    try {
      loading?.call();
      final response = await this;
      if (response.statusCode == 200) {
        done?.call();
        return success?.call(response);
      } else {
        done?.call();
        throw DioException(
          requestOptions: response.requestOptions,
          type: DioExceptionType.badResponse,
          response: response,
          error: response.data,
          message: response.statusMessage,
          stackTrace: StackTrace.current,
        );
      }
    } on DioException catch (e) {
      log("Error: ${e.error}, Response: ${e.response}, Message: ${e.message}, StackTrace: ${e.stackTrace}, RequestOptions: ${e.requestOptions}, Type: ${e.type}",
          name: "DioException Error");
      if (e.response?.data != null) {
        error?.call(e.response?.data);
        throw Exception(e.response?.data);
      } else {
        error?.call(e.error);
        throw Exception(e.response?.statusMessage);
      }
    } catch (e) {
      log("Error: $e", name: "Catch Error");
      error?.call(e);
      throw Exception(e);
    }
  }
}
