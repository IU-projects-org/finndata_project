// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symbol_result.dart';

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
