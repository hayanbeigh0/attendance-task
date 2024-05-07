import 'dart:developer';
import 'dart:io';

import 'package:attendance/repositories/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'send_image_state.dart';

class SendImageCubit extends Cubit<SendImageState> {
  SendImageCubit() : super(SendImageInitial());

  sendImage(BuildContext context, File imageFile) async {
    emit(SendImageStarted());
    try {
      final response = await API().sendImage(context, imageFile);
      log(response!.data!.toString());
      emit(SendImageDone(imageFile));
    } on DioException catch (e) {
      log(e.toString());
      emit(SendImageFailed(imageFile, e.response!.data['messageCode']));
    }
  }
}
