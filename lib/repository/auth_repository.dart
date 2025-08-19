import 'package:boiler_plate/constant/app_strings.dart';
import 'package:boiler_plate/models/request_model/login_request_model.dart';
import 'package:boiler_plate/services/api/api_services.dart';
import 'package:boiler_plate/services/response_wrapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient(Dio());

  Future<ResponseWrapper> signIn(LoginRequestModel loginRequestModel) async {
    try {
      ResponseWrapper response = await _apiClient.postReq(
        AppStrings.signInEndPoint,
        data: loginRequestModel.toJson(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseWrapper> logout(BuildContext context) async {
    try {
      ResponseWrapper response = await _apiClient.postReq(
        AppStrings.logOutEndPoint,
        data: {},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
