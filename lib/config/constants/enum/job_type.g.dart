// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobTypeAdapter extends TypeAdapter<JobType> {
  @override
  final int typeId = 1;

  @override
  JobType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return JobType.order;
      case 1:
        return JobType.lot;
      default:
        return JobType.order;
    }
  }

  @override
  void write(BinaryWriter writer, JobType obj) {
    switch (obj) {
      case JobType.order:
        writer.writeByte(0);
        break;
      case JobType.lot:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
