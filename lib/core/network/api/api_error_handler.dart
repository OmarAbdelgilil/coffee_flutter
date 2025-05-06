// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';

class ServerError implements Exception {
  final String? serverMessage;
  final int? statusCode;
  ServerError(this.serverMessage, this.statusCode);
}

class DioHttpException implements Exception {
  final DioException dioException;

  DioHttpException(this.dioException);

  String get errorMessage {
    try {
      print(dioException.response);
      final data = dioException.response?.data;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        return data['message'];
      }
      return 'Unexpected error occurred.';
    } catch (_) {
      return 'Unexpected error occurred.';
    }
  }
}

class NoInternetError implements Exception {}
