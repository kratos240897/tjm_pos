import 'package:evolvex_lib/evolvex_lib.dart';

import '../../data/dto/job.dart';

abstract class AddJobRepository {
  Future<DataState<Job>> addJob(Job job);
}
