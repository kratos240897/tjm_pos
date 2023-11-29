import 'package:evolvex_lib/evolvex_lib.dart';

import '../../data/dto/job.dart';
import '../repositories/home_repository.dart';

class GetAllJobsUsecase implements UseCase<DataState<List<Job>>, void> {
  final HomeRepository _homeRepository;

  GetAllJobsUsecase({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;
  @override
  Future<DataState<List<Job>>> call({void params}) async {
    return await _homeRepository.getAllJobs();
  }
}
