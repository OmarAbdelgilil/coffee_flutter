import 'dart:async';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:coffe_front/core/common/api_result.dart';
import 'package:coffe_front/core/network/api/api_error_handler.dart';
import 'package:dio/dio.dart';

Future<Result<T>> executeApi<T>(Future<T> Function() apiCall) async {
  try {
    var result = await apiCall.call();
    return Success(result);
  } on TimeoutException {
    return Fail(NoInternetError());
  } on IOException {
    return Fail(NoInternetError());
  } on DioException catch (ex) {
    return Fail(DioHttpException(ex));
  } on Exception catch (ex) {
    return Fail(ex);
  }
}
