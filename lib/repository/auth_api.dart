import 'dart:io';

import 'package:dio/dio.dart';
import 'package:edspert_finalproject/constants/R/api_url.dart';
import 'package:edspert_finalproject/helpers/user_email.dart';
import 'package:edspert_finalproject/models/latihan_soal_skor.dart';
import 'package:edspert_finalproject/models/network_response.dart';

class AuthApi {
  Dio dioApi() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      headers: {
        "x-api-key": ApiUrl.apiKey,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      responseType: ResponseType.json,
    );
    final dio = Dio(options);
    return dio;
  }

  Future<NetworkResponse> _getRequest({endpoint, param}) async {
    try {
      final dio = dioApi();
      final result = await dio.get(endpoint, queryParameters: param);
      return NetworkResponse.success(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        return NetworkResponse.Error(data: null, message: "request timeout");
      }
      return NetworkResponse.Error(data: null, message: "request error dio");
    } catch (e) {
      return NetworkResponse.Error(data: null, message: "request error");
    }
  }

  Future<NetworkResponse> _postRequest({endpoint, body}) async {
    try {
      final dio = dioApi();
      final result = await dio.post(endpoint, data: body);
      return NetworkResponse.success(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        return NetworkResponse.Error(data: null, message: "request timeout");
      }
      return NetworkResponse.Error(data: null, message: "request error dio");
    } catch (e) {
      return NetworkResponse.Error(data: null, message: "request error");
    }
  }

  Future<NetworkResponse> getUserByEmail() async {
    // final String emailXX = "gatotcoba@gmail.com";

    final result = await _getRequest(
      endpoint: ApiUrl.users,
      param: {"email": UserEmail.getUserEmail()},
    );
    return result;
  }

  Future<NetworkResponse> postRegister(body) async {
    final result = await _postRequest(
      endpoint: ApiUrl.usersRegistrasi,
      body: body,
    );
    return result;
  }
}