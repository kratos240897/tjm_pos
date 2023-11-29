import 'package:equatable/equatable.dart';

import '../../../config/constants/enum/job_status.dart';
import '../../../config/constants/enum/job_type.dart';
import 'package:hive/hive.dart';

part 'job.g.dart';

@HiveType(typeId: 0)
class Job extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final DateTime dueDate;
  @HiveField(3)
  final DateTime? startDate;
  @HiveField(4)
  final DateTime? endDate;
  @HiveField(5)
  final DateTime? billedDate;
  @HiveField(6)
  final DateTime? paymentReceivedDate;
  @HiveField(7)
  final JobType type;
  @HiveField(8)
  JobStatus status;
  @HiveField(9)
  final double weight;
  @HiveField(10, defaultValue: 0)
  double completion;

  Job({
    required this.id,
    required this.name,
    required this.dueDate,
    this.startDate,
    this.endDate,
    this.billedDate,
    this.paymentReceivedDate,
    required this.type,
    required this.status,
    required this.weight,
    this.completion = 0,
  }) : assert(completion >= 0 && completion <= 5,
            'Completion must be between 0 to 5');

  @override
  List<Object?> get props => [
        id,
        name,
        dueDate,
        startDate,
        endDate,
        billedDate,
        paymentReceivedDate,
        type,
        status,
        weight,
        completion
      ];
}
