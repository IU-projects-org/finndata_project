import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'symbol_result.g.dart';

@JsonSerializable(includeIfNull: true)
@HiveType(typeId: 1)
class SymbolResultModel {
  SymbolResultModel(
      this.description, this.type, this.displaySymbol, this.symbol);

  factory SymbolResultModel.fromJson(Map<String, dynamic> json) =>
      _$SymbolResultModelFromJson(json);
  @HiveField(0)
  final String description;
  @HiveField(1)
  final String displaySymbol;
  @HiveField(2)
  final String symbol;
  @HiveField(3)
  final String type;

  Map<String, dynamic> toJson() => _$SymbolResultModelToJson(this);
}
