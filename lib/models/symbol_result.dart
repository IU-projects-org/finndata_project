import 'package:json_annotation/json_annotation.dart';

part 'symbol_result.g.dart';

@JsonSerializable(explicitToJson: true)
class SymbolResultModel {
  SymbolResultModel(
      this.description, this.type, this.displaySymbol, this.symbol);

  factory SymbolResultModel.fromJson(Map<String, dynamic> json) =>
      _$SymbolResultModelFromJson(json);

  final String description, displaySymbol, symbol, type;

  Map<String, dynamic> toJson() => _$SymbolResultModelToJson(this);
}
