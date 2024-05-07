part of 'progress_cubit.dart';

abstract class ProgressState extends Equatable {}

final class ProgressInitial extends ProgressState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ProgressUpdated extends ProgressState {
  final double progress;

  ProgressUpdated(this.progress);
    @override
  // TODO: implement props
  List<Object?> get props => [progress];
}
