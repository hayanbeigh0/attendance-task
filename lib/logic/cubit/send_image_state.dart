part of 'send_image_cubit.dart';

abstract class SendImageState {}

final class SendImageInitial extends SendImageState {}

final class SendImageStarted extends SendImageState {}

final class SendImageDone extends SendImageState {
  final File? imageFile;

  SendImageDone(this.imageFile);
}

final class SendImageFailed extends SendImageState {
  final File? imageFile;
  final String messageCode;

  SendImageFailed(this.imageFile, this.messageCode);
}
