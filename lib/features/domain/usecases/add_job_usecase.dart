import 'package:evolvex_lib/evolvex_lib.dart';

import '../../data/dto/job.dart';
import '../repositories/add_job_repository.dart';

class AddJobUsecase implements UseCase<DataState<Job>, Job> {
  final AddJobRepository _addJobRepository;

  AddJobUsecase({required AddJobRepository addJobRepository})
      : _addJobRepository = addJobRepository;

  @override
  Future<DataState<Job>> call({Job? params}) async {
    return await _addJobRepository.addJob(params!);
  }
}
