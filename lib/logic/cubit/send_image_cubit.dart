import 'dart:developer';
import 'dart:io';

import 'package:attendance/repositories/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'send_image_state.dart';

class SendImageCubit extends Cubit<SendImageState> {
  SendImageCubit() : super(SendImageInitial());

  sendImage(File imageFile) async {
    emit(SendImageStarted());
    try {
      final response = await API().sendImage(imageFile);
      log(response.toString());
      emit(SendImageDone());
    } catch (e) {
      log(e.toString());
      emit(SendImageFailed());
    }
  }
}
