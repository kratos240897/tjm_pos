// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobStatusAdapter extends TypeAdapter<JobStatus> {
  @override
  final int typeId = 2;

  @override
  JobStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return JobStatus.notYetStarted;
      case 1:
        return JobStatus.atWork;
      case 2:
        return JobStatus.atTesting;
      case 3:
        return JobStatus.delivered;
      case 4:
        return JobStatus.yetToBeDelivered;
      case 5:
        return JobStatus.billed;
      case 6:
        return JobStatus.yetToBeBilled;
      case 7:
        return JobStatus.recieved;
      case 8:
        return JobStatus.yetToBeRecieved;
      default:
        return JobStatus.notYetStarted;
    }
  }

  @override
  void write(BinaryWriter writer, JobStatus obj) {
    switch (obj) {
      case JobStatus.notYetStarted:
        writer.writeByte(0);
        break;
      case JobStatus.atWork:
        writer.writeByte(1);
        break;
      case JobStatus.atTesting:
        writer.writeByte(2);
        break;
      case JobStatus.delivered:
        writer.writeByte(3);
        break;
      case JobStatus.yetToBeDelivered:
        writer.writeByte(4);
        break;
      case JobStatus.billed:
        writer.writeByte(5);
        break;
      case JobStatus.yetToBeBilled:
        writer.writeByte(6);
        break;
      case JobStatus.recieved:
        writer.writeByte(7);
        break;
      case JobStatus.yetToBeRecieved:
        writer.writeByte(8);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
