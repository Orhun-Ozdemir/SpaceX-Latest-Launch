import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:spacex_app/base/const/const.dart';
import 'package:spacex_app/model/spacex_model.dart';

class SpaceXService {
  final String apiurl = url;
  final Dio dio = Dio();

  Future<SpaceX> fetchdata() async {
    Response response = await dio.get(apiurl);
    if (response.statusCode == 200) {
      SpaceX data = SpaceX.fromJson(response.data);
      debugPrint(data.toString());
      return data;
    } else {
      throw Exception(" Error");
    }
  }
}
