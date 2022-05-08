import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quiver/core.dart';

part 'symbol_result.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class SymbolResultModel {
  const SymbolResultModel(
      this.description, this.type, this.displaySymbol, this.symbol);

  factory SymbolResultModel.fromJson(Map<String, dynamic> json) =>
      _$SymbolResultModelFromJson(json);

  final String description, displaySymbol, symbol, type;

  Map<String, dynamic> toJson() => _$SymbolResultModelToJson(this);

  @override
  bool operator ==(Object other) =>
      // ignore: avoid_bool_literals_in_conditional_expressions
      (other is SymbolResultModel) ? (
        description == other.description &&
        displaySymbol == other.displaySymbol &&
        symbol == other.symbol &&
        type == other.type
      ) : false;

  @override
  int get hashCode => hash4(description, displaySymbol, symbol, type);
}
