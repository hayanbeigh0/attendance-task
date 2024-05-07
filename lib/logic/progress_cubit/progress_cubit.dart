import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit() : super(ProgressInitial());

  sendProgress(double progress){
    emit(ProgressInitial());
    emit(ProgressUpdated(progress));
  }
}
