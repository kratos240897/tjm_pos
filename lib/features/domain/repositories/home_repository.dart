import 'package:evolvex_lib/evolvex_lib.dart';

import '../../data/dto/job.dart';

abstract class HomeRepository {
  Future<DataState<List<Job>>> getAllJobs();
}
