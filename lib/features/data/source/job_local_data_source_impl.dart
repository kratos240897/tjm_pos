import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tjm_pos/config/constants/enum/job_status.dart';
import 'package:tjm_pos/config/constants/enum/job_type.dart';

import '../../../config/constants/app/constants.dart';
import '../dto/job.dart';
import 'job_local_data_source.dart';

class JobLocalDataSourceImpl extends JobLocalDataSource {
  late final Box<Job> _jobBox;

  @override
  Future<void> initDB() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(JobTypeAdapter());
      Hive.registerAdapter(JobStatusAdapter());
      Hive.registerAdapter(JobAdapter());
      _jobBox = await Hive.openBox<Job>(Constants.db);
    } catch (e) {
      if (kDebugMode) {
        print('DB initialization error $e');
      }
      return Future.error(e);
    }
  }

  @override
  Future<List<Job>> getAllJobs() async {
    try {
      return _jobBox.values
          .map<Job>((e) => Job(
              id: e.id,
              name: e.name,
              dueDate: e.dueDate,
              type: e.type,
              status: e.status,
              weight: e.weight))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('Get all values from DB error $e');
      }
      return Future.error(e);
    }
  }

  @override
  Future<Job> addJob(Job job) async {
    try {
      await _jobBox.add(job);
      return _jobBox.get(job.key)!;
    } catch (e) {
      if (kDebugMode) {
        print('Add to DB error $e');
      }
      return Future.error(e);
    }
  }

  @override
  Future<void> deleteJob(Job job) async {
    try {
      await _jobBox.delete(job.key);
    } catch (e) {
      if (kDebugMode) {
        print('Delete from DB error $e');
      }
      return Future.error(e);
    }
  }

  @override
  Future<void> updateJob(Job job) async {
    try {
      await _jobBox.put(job.key, job);
    } catch (e) {
      if (kDebugMode) {
        print('Update in DB error $e');
      }
      return Future.error(e);
    }
  }
}
