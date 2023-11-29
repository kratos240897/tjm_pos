import 'package:get_it/get_it.dart';

import '../../features/data/repositories/add_job_repository_impl.dart';
import '../../features/data/repositories/home_repository_impl.dart';
import '../../features/data/source/job_local_data_source.dart';
import '../../features/data/source/job_local_data_source_impl.dart';
import '../../features/domain/repositories/add_job_repository.dart';
import '../../features/domain/repositories/home_repository.dart';
import '../../features/domain/usecases/add_job_usecase.dart';
import '../../features/domain/usecases/get_jobs_usecase.dart';
import '../../features/presentation/cubit/add_job_cubit.dart';
import '../../features/presentation/cubit/home_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // DATA SOURCE
  sl.registerLazySingleton<JobLocalDataSource>(() => JobLocalDataSourceImpl());

  // REPOSITORIES
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(jobLocalDataSource: sl()));
  sl.registerLazySingleton<AddJobRepository>(
      () => AddJobRepositoryImpl(jobLocalDataSource: sl()));

  // USECASES
  sl.registerLazySingleton(() => GetAllJobsUsecase(homeRepository: sl()));
  sl.registerLazySingleton(() => AddJobUsecase(addJobRepository: sl()));

  // BLOC
  sl.registerFactory(() => HomeCubit(sl()));
  sl.registerFactory(() => AddJobCubit(sl()));
}
