import '../dto/job.dart';

abstract class JobLocalDataSource {
  Future<void> initDB();
  Future<List<Job>> getAllJobs();
  Future<Job> addJob(Job job);
  Future<void> deleteJob(Job job);
  Future<void> updateJob(Job job);
}
