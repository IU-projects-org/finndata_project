// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symbol_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SymbolResultModelAdapter extends TypeAdapter<SymbolResultModel> {
  @override
  final int typeId = 1;

  @override
  SymbolResultModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SymbolResultModel(
      fields[0] as String,
      fields[3] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SymbolResultModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.displaySymbol)
      ..writeByte(2)
      ..write(obj.symbol)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SymbolResultModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SymbolResultModel _$SymbolResultModelFromJson(Map<String, dynamic> json) =>
    SymbolResultModel(
      json['description'] as String,
      json['type'] as String,
      json['displaySymbol'] as String,
      json['symbol'] as String,
    );

Map<String, dynamic> _$SymbolResultModelToJson(SymbolResultModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'displaySymbol': instance.displaySymbol,
      'symbol': instance.symbol,
      'type': instance.type,
    };
