import 'package:flutter/material.dart';

import '../../main.dart';
import '../constants/enum/job_status.dart';

extension JobStatusColorExtension on JobStatus {
  (Color, Color) get color {
    switch (this) {
      case JobStatus.notYetStarted:
      case JobStatus.yetToBeDelivered:
      case JobStatus.yetToBeBilled:
      case JobStatus.yetToBeRecieved:
        return (orangeAccent, orange);
      case JobStatus.atWork:
      case JobStatus.atTesting:
        return (yellowAccent, Colors.black87);
      case JobStatus.delivered:
      case JobStatus.billed:
      case JobStatus.recieved:
        return (greenAccent, green);
    }
  }
}
