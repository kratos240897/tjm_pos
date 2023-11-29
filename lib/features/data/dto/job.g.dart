// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobAdapter extends TypeAdapter<Job> {
  @override
  final int typeId = 0;

  @override
  Job read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Job(
      id: fields[0] as String,
      name: fields[1] as String,
      dueDate: fields[2] as DateTime,
      startDate: fields[3] as DateTime?,
      endDate: fields[4] as DateTime?,
      billedDate: fields[5] as DateTime?,
      paymentReceivedDate: fields[6] as DateTime?,
      type: fields[7] as JobType,
      status: fields[8] as JobStatus,
      weight: fields[9] as double,
      completion: fields[10] == null ? 0 : fields[10] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Job obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.dueDate)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.billedDate)
      ..writeByte(6)
      ..write(obj.paymentReceivedDate)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.weight)
      ..writeByte(10)
      ..write(obj.completion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
