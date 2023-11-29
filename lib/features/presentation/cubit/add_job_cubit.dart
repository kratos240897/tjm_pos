import 'package:evolvex_lib/evolvex_lib.dart';

import '../../data/dto/job.dart';
import '../../domain/usecases/add_job_usecase.dart';

abstract class AddJobState extends BaseState {}

class AddJobInitial extends AddJobState {}

class AddJobLoading extends AddJobState {}

class AddJobSuccess extends AddJobState {
  final Job job;

  AddJobSuccess({required this.job});
}

class AddJobError extends AddJobState {
  final String errorMessage;

  AddJobError({required this.errorMessage});
}

class AddJobCubit extends BaseCubit<AddJobState> {
  AddJobCubit(this._addJobUsecase) : super(initialState: AddJobInitial());
  final AddJobUsecase _addJobUsecase;

  addJob(Job job) async {
    emit(AddJobLoading());
    final dataState = await _addJobUsecase.call(params: job);
    if (dataState is DataSuccess) {
      emit(AddJobSuccess(job: dataState.data!));
    } else {
      emit(getErrorState(dataState.error!));
    }
  }

  @override
  AddJobState getErrorState(Object error) {
    return AddJobError(errorMessage: 'An error occured: $error');
  }
}
