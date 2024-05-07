import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:attendance/logic/progress_cubit/progress_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class API {
  Future<Response?> sendImage(BuildContext context, File imageFile) async {
    Dio dio = Dio();

    String url = 'https://natours-8p4c.onrender.com/api/v1/uploads/image';

    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: 'image.jpg',
      ),
    });

    Response response = await dio.post(
      url,
      data: formData,
      onSendProgress: (int sent, int total) {
        double progress = sent / total;
        // log('Uploading progress: ${progress.toStringAsFixed(2)}');
        BlocProvider.of<ProgressCubit>(context).sendProgress(progress);
      },
    );

    log('Image sent successfully');
    return response;
  }
}
