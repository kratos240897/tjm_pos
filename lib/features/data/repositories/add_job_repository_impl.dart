import 'package:evolvex_lib/evolvex_lib.dart';

import '../../domain/repositories/add_job_repository.dart';
import '../dto/job.dart';
import '../source/job_local_data_source.dart';

class AddJobRepositoryImpl extends AddJobRepository {
  final JobLocalDataSource _jobLocalDataSource;

  AddJobRepositoryImpl({required JobLocalDataSource jobLocalDataSource})
      : _jobLocalDataSource = jobLocalDataSource;
  @override
  Future<DataState<Job>> addJob(Job job) async {
    try {
      final data = await _jobLocalDataSource.addJob(job);
      return DataSuccess(data);
    } catch (e) {
      return DataFailed(UnknownError(message: e.toString()));
    }
  }
}
