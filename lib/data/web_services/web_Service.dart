import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:qr_ieee/constants/strings.dart';

import '../model/Person.dart';

class QrWebServices {
  final Dio dio;
  QrWebServices(this.dio);

  Future<dynamic> getPersonData({required String code}) async {
    try {

      Response response = await dio.post(baseUrl,
          options: Options(responseType: ResponseType.bytes),
          data: FormData.fromMap({'code': code}));

      var data = Utf8Codec().decode(response.data);


      if (data[2] == 's')
        return jsonDecode(data);
      else{

        return Person.fromJson(jsonDecode(data));
      }


    } on DioException catch (e) {
      print(e.error);
    } catch (e) {
      print(e.toString());
    }
  }
}
