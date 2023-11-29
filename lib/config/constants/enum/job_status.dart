import 'package:hive/hive.dart';
part 'job_status.g.dart';


@HiveType(typeId: 2)
enum JobStatus {
  @HiveField(0)
  notYetStarted,
  @HiveField(1)
  atWork,
  @HiveField(2)
  atTesting,
  @HiveField(3)
  delivered,
  @HiveField(4)
  yetToBeDelivered,
  @HiveField(5)
  billed,
  @HiveField(6)
  yetToBeBilled,
  @HiveField(7)
  recieved,
  @HiveField(8)
  yetToBeRecieved
}
