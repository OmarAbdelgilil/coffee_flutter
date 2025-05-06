// ignore: depend_on_referenced_packages
import 'dart:io';

import 'package:coffe_front/core/network/api/api_constants.dart';
import 'package:coffe_front/features/auth/data/models/requests/login_request.dart';
import 'package:coffe_front/features/auth/data/models/requests/register_request.dart';
import 'package:coffe_front/features/auth/data/models/responses/login_response.dart';
import 'package:coffe_front/features/auth/data/models/responses/register_response.dart';
import 'package:coffe_front/features/demand/data/models/requests/top_sold_request.dart';
import 'package:coffe_front/features/demand/data/models/responses/top_sold_response/top_sold_response.dart';
import 'package:coffe_front/features/home/data/models/requests/revenue_expense_request.dart';
import 'package:coffe_front/features/home/data/models/responses/revenue_response_response/revenue_response_response.dart';
import 'package:coffe_front/features/inventory/data/models/requests/buy_ing_request.dart';
import 'package:coffe_front/features/inventory/data/models/responses/buy_ing_response.dart';
import 'package:coffe_front/features/inventory/data/models/responses/ingredients_response/ingredients_response.dart';
import 'package:coffe_front/features/profiles/data/models/requests/delete_user_request.dart';
import 'package:coffe_front/features/profiles/data/models/responses/delete_user_response.dart';
import 'package:coffe_front/features/profiles/data/models/responses/users_response/users_response.dart';
import 'package:coffe_front/features/shop/data/models/requests/order_request/order_request.dart';
import 'package:coffe_front/features/shop/data/models/responses/items_response/items_response.dart';
import 'package:coffe_front/features/shop/data/models/responses/order_response.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../providers/token_provider.dart';

part 'api_manager.g.dart';

@singleton
@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiManager {
  @factoryMethod
  factory ApiManager(Dio dio, TokenProvider tokenProvider) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = tokenProvider.token;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );

    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (
      HttpClient client,
    ) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    return _ApiManager(dio);
  }

  @POST(ApiConstants.registerPath)
  Future<RegisterResponse> register(@Body() RegisterRequest request);

  @POST(ApiConstants.loginPath)
  Future<LoginResponse> login(@Body() LoginRequest request);

  @GET(ApiConstants.revenuePath)
  Future<RevenueResponseResponse> getRevenueExpense(
    @Body() RevenueExpenseRequest request,
  );

  @POST(ApiConstants.topSoldPath)
  Future<TopSoldResponse> getTopSold(@Body() TopSoldRequest request);

  @GET(ApiConstants.predictPath)
  Future<TopSoldResponse> getPredictions();

  @GET(ApiConstants.allIngredientsPath)
  Future<IngredientsResponse> getAllIngredients();

  @POST(ApiConstants.buyIngPath)
  Future<BuyIngResponse> buyIngredient(@Body() BuyIngRequest request);

  @GET(ApiConstants.allUsersPath)
  Future<UsersResponse> getAllUsers();

  @GET(ApiConstants.itemsPath)
  Future<ItemsResponse> getAllItems();

  @POST(ApiConstants.orderPath)
  Future<OrderResponse> makeOrder(@Body() OrderRequest request);

  @DELETE(ApiConstants.deleteUserPath)
  Future<DeleteUserResponse> deleteUser(@Body() DeleteUserRequest request);
}
