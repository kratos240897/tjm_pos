import 'package:evolvex_lib/evolvex_lib.dart';

import '../../data/dto/job.dart';
import '../../domain/usecases/get_jobs_usecase.dart';

sealed class HomeState extends BaseState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<Job> jobs;

  copyWith(List<Job> updatedJobs) {
    jobs.clear();
    jobs.addAll(updatedJobs);
  }

  add(Job job) {
    jobs.insert(0, job);
  }

  remove(Job job) {
    jobs.remove(job);
  }

  HomeLoadedState({
    required this.jobs,
  });
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState({required this.errorMessage});
}

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit(this._getAllJobsUsecase) : super(initialState: HomeInitialState());
  final GetAllJobsUsecase _getAllJobsUsecase;
  final HomeLoadedState _homeLoadedState = HomeLoadedState(jobs: []);

  Future<void> addJobToHomeList(Job job) async {
    emit(HomeLoadingState());
    emit(_homeLoadedState..add(job));
  }

  Future<void> removeJob(Job job) async {
    emit(HomeLoadingState());
    emit(_homeLoadedState..remove(job));
  }

  Future<void> updateCompletion(Job job) async {
    emit(HomeLoadingState());
    
  }

  Future<void> getAllJobs() async {
    emit(HomeLoadingState());
    final dataState = await _getAllJobsUsecase.call();
    if (dataState is DataSuccess) {
      emit(_homeLoadedState..copyWith(dataState.data!));
    } else {
      emit(getErrorState(dataState.error!));
    }
  }

  @override
  HomeState getErrorState(Object error) {
    return HomeErrorState(errorMessage: 'An error occured: $error');
  }
}
