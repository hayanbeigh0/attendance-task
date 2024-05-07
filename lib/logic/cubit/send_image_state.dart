part of 'send_image_cubit.dart';

abstract class SendImageState {}

final class SendImageInitial extends SendImageState {}

final class SendImageStarted extends SendImageState {}

final class SendImageDone extends SendImageState {}

final class SendImageFailed extends SendImageState {}
