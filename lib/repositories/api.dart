import 'dart:convert';

import 'package:dio/dio.dart';

class API {
  sendImage(var image) {
    final response = Dio().post(
      'path',
      data: jsonEncode(
        {
          image: image,
        },
      ),
    );
  }
}
