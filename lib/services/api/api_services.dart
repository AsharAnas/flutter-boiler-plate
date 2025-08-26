import 'dart:developer';
import 'dart:io';

import 'package:boiler_plate/constant/app_constant.dart';
import 'package:boiler_plate/constant/app_strings.dart';
import 'package:boiler_plate/services/http_status_manager.dart';
import 'package:boiler_plate/services/response_wrapper.dart';
import 'package:dio/dio.dart';

class ApiClient {
  Dio? _dio;
  final List<Interceptor>? interceptors;

  ApiClient(Dio dio, {this.interceptors}) {
    _dio = dio;
    final customHeaders = <String, dynamic>{};
    customHeaders['Content-Type'] = 'application/json';
    customHeaders['Accept'] = 'application/json';

    _dio
      ?..options.baseUrl = AppStrings.baseUrl
      ..options.connectTimeout = const Duration(minutes: 2)
      ..options.receiveTimeout = const Duration(minutes: 2)
      ..httpClientAdapter
      ..options.headers = customHeaders
      ..options.validateStatus = (int? status) {
        return status == null || (status >= 200 && status < 300) || status == 404;
      };
    if (interceptors?.isNotEmpty ?? false) {
      _dio?.interceptors.addAll(interceptors ?? []);
    }
  }

  ResponseWrapper _response(Response? response) {
    return ResponseWrapper(data: response?.data, message: "", statusCode: response?.statusCode);
  }

  Future<ResponseWrapper<dynamic>> getReq(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    dynamic data,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      options ??= Options();
      options.headers = {...?options.headers, 'Authorization': token, 'Content-Type': 'application/json'};

      var response = await _dio?.get(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      // Handle status code and return the response
      HttpStatusManager.handleStatusCode(_response(response));
      return _response(response);
    } on DioException catch (e) {
      log('DioException: ${e.response?.statusCode} ${e.response?.statusMessage}');
      log('DioException Data: ${e.response?.data}');

      if (e.type == DioExceptionType.connectionError) {
        return ResponseWrapper.error(message: 'No internet connection. Please check your network.', statusCode: e.response?.statusCode);
      }

      final responseData = e.response?.data;
      String formattedMessage;

      if (responseData is Map && responseData['message'] != null) {
        final rawMessage = responseData['message'];
        if (rawMessage is List) {
          formattedMessage = rawMessage.join('\n');
        } else if (rawMessage is String) {
          formattedMessage = rawMessage;
        } else {
          formattedMessage = 'An unknown error occurred.';
        }
      } else if (e.response?.statusCode == 502) {
        formattedMessage = 'Server is temporarily unavailable. Please try again later.';
      } else {
        formattedMessage = 'Something went wrong. Please try again.';
      }

      return ResponseWrapper.error(message: formattedMessage, statusCode: e.response?.statusCode);
    } on SocketException catch (e) {
      log('SocketException: ${e.toString()}');
      return ResponseWrapper.error(message: 'No internet connection. Please try again.');
    } on FormatException catch (e) {
      log('FormatException: ${e.toString()}');
      return ResponseWrapper.error(message: 'Invalid response format');
    } catch (e) {
      log('Exception: ${e.toString()}');
      return ResponseWrapper.error(message: e.toString());
    }
  }

  Future<ResponseWrapper<dynamic>> postReq(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      // Set headers
      options ??= Options();
      options.headers = {...?options.headers, 'Authorization': token, 'Content-Type': 'application/json'};

      // Perform the API request
      var response = await _dio?.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      // Handle status code and return the response
      HttpStatusManager.handleStatusCode(_response(response));
      return _response(response);
    } on DioException catch (e) {
      log('DioException: ${e.response?.statusCode} ${e.response?.statusMessage}');
      log('DioException Data: ${e.response?.data}');

      if (e.type == DioExceptionType.connectionError) {
        return ResponseWrapper.error(message: 'No internet connection. Please check your network.', statusCode: e.response?.statusCode);
      }

      final responseData = e.response?.data;
      String formattedMessage;

      if (responseData is Map && responseData['message'] != null) {
        final rawMessage = responseData['message'];
        if (rawMessage is List) {
          formattedMessage = rawMessage.join('\n');
        } else if (rawMessage is String) {
          formattedMessage = rawMessage;
        } else {
          formattedMessage = 'An unknown error occurred.';
        }
      } else if (e.response?.statusCode == 502) {
        formattedMessage = 'Server is temporarily unavailable. Please try again later.';
      } else {
        formattedMessage = 'Something went wrong. Please try again.';
      }

      return ResponseWrapper.error(message: formattedMessage, statusCode: e.response?.statusCode);
    } on SocketException catch (e) {
      log('SocketException: ${e.toString()}');
      return ResponseWrapper.error(message: 'No internet connection. Please try again.');
    } on FormatException catch (e) {
      log('FormatException: ${e.toString()}');
      return ResponseWrapper.error(message: 'Invalid response format');
    } catch (e) {
      log('Exception: ${e.toString()}');
      return ResponseWrapper.error(message: e.toString());
    }
  }

  Future<ResponseWrapper<dynamic>> patchReq(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      options ??= Options();
      options.headers = {...?options.headers, 'Authorization': token, 'Content-Type': 'application/json'};

      var response = await _dio?.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return _response(response);
    } on DioException catch (e) {
      log('DioException: ${e.response?.statusCode} ${e.response?.statusMessage}');
      log('DioException Data: ${e.response?.data}');

      if (e.type == DioExceptionType.connectionError) {
        return ResponseWrapper.error(message: 'No internet connection. Please check your network.', statusCode: e.response?.statusCode);
      }

      final responseData = e.response?.data;
      String formattedMessage;

      if (responseData is Map && responseData['message'] != null) {
        final rawMessage = responseData['message'];
        if (rawMessage is List) {
          formattedMessage = rawMessage.join('\n');
        } else if (rawMessage is String) {
          formattedMessage = rawMessage;
        } else {
          formattedMessage = 'An unknown error occurred.';
        }
      } else if (e.response?.statusCode == 502) {
        formattedMessage = 'Server is temporarily unavailable. Please try again later.';
      } else {
        formattedMessage = 'Something went wrong. Please try again.';
      }

      return ResponseWrapper.error(message: formattedMessage, statusCode: e.response?.statusCode);
    } on SocketException catch (e) {
      log('SocketException: ${e.toString()}');
      return ResponseWrapper.error(message: 'No internet connection. Please try again.');
    } on FormatException catch (e) {
      log('FormatException: ${e.toString()}');
      return ResponseWrapper.error(message: 'Invalid response format');
    } catch (e) {
      log('Exception: ${e.toString()}');
      return ResponseWrapper.error(message: e.toString());
    }
  }

  Future<ResponseWrapper<dynamic>> putReq(
    String uri, {
    data,
    bool isS3 = false,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      options ??= Options();
      if (!isS3) {
        options.headers = {...?options.headers, 'Authorization': token, 'Content-Type': 'application/json'};
      }

      var response = await _dio?.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return _response(response);
    } on DioException catch (e) {
      log('DioException: ${e.response?.statusCode} ${e.response?.statusMessage}');
      log('DioException Data: ${e.response?.data}');

      if (e.type == DioExceptionType.connectionError) {
        return ResponseWrapper.error(message: 'No internet connection. Please check your network.', statusCode: e.response?.statusCode);
      }

      final responseData = e.response?.data;
      String formattedMessage;

      if (responseData is Map && responseData['message'] != null) {
        final rawMessage = responseData['message'];
        if (rawMessage is List) {
          formattedMessage = rawMessage.join('\n');
        } else if (rawMessage is String) {
          formattedMessage = rawMessage;
        } else {
          formattedMessage = 'An unknown error occurred.';
        }
      } else if (e.response?.statusCode == 502) {
        formattedMessage = 'Server is temporarily unavailable. Please try again later.';
      } else {
        formattedMessage = 'Something went wrong. Please try again.';
      }

      return ResponseWrapper.error(message: formattedMessage, statusCode: e.response?.statusCode);
    } on SocketException catch (e) {
      log('SocketException: ${e.toString()}');
      return ResponseWrapper.error(message: 'No internet connection. Please try again.');
    } on FormatException catch (e) {
      log('FormatException: ${e.toString()}');
      return ResponseWrapper.error(message: 'Invalid response format');
    } catch (e) {
      log('Exception: ${e.toString()}');
      return ResponseWrapper.error(message: e.toString());
    }
  }

  Future<ResponseWrapper<dynamic>> deleteReq(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      options ??= Options();
      options.headers = {...?options.headers, 'Authorization': token, 'Content-Type': 'application/json'};
      var response = await _dio?.delete(uri, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
      return _response(response);
    } on DioException catch (e) {
      log('DioException: ${e.response?.statusCode} ${e.response?.statusMessage}');
      log('DioException Data: ${e.response?.data}');

      if (e.type == DioExceptionType.connectionError) {
        return ResponseWrapper.error(message: 'No internet connection. Please check your network.', statusCode: e.response?.statusCode);
      }

      final responseData = e.response?.data;
      String formattedMessage;

      if (responseData is Map && responseData['message'] != null) {
        final rawMessage = responseData['message'];
        if (rawMessage is List) {
          formattedMessage = rawMessage.join('\n');
        } else if (rawMessage is String) {
          formattedMessage = rawMessage;
        } else {
          formattedMessage = 'An unknown error occurred.';
        }
      } else if (e.response?.statusCode == 502) {
        formattedMessage = 'Server is temporarily unavailable. Please try again later.';
      } else {
        formattedMessage = 'Something went wrong. Please try again.';
      }

      return ResponseWrapper.error(message: formattedMessage, statusCode: e.response?.statusCode);
    } on SocketException catch (e) {
      log('SocketException: ${e.toString()}');
      return ResponseWrapper.error(message: 'No internet connection. Please try again.');
    } on FormatException catch (e) {
      log('FormatException: ${e.toString()}');
      return ResponseWrapper.error(message: 'Invalid response format');
    } catch (e) {
      log('Exception: ${e.toString()}');
      return ResponseWrapper.error(message: e.toString());
    }
  }
}
