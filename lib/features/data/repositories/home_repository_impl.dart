import 'package:evolvex_lib/evolvex_lib.dart';

import '../../domain/repositories/home_repository.dart';
import '../dto/job.dart';
import '../source/job_local_data_source.dart';


class HomeRepositoryImpl extends HomeRepository {
  final JobLocalDataSource _jobLocalDataSource;

  HomeRepositoryImpl({required JobLocalDataSource jobLocalDataSource})
      : _jobLocalDataSource = jobLocalDataSource;
  @override
  Future<DataState<List<Job>>> getAllJobs() async {
    try {
      final data = await _jobLocalDataSource.getAllJobs();
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(UnknownError(message: e.toString()));
    }
  }
}
