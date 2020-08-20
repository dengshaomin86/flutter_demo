import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../components/toast.dart';
import '../config/service.dart';

Future getHomePageContent(String data) async {
  Response response;
  Dio dio = new Dio();
  response = await dio
      .get("${serviceUrl}/flutter/getList", queryParameters: {"text": data});
  ToastCustomer.show(response.data["message"]);
  if (response.statusCode == 200) {
    return response.data;
  } else {
    return [];
  }
}
