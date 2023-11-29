import 'package:hive/hive.dart';
part 'job_type.g.dart';

@HiveType(typeId: 1)
enum JobType {
  @HiveField(0)
  order,
  @HiveField(1)
  lot
}
