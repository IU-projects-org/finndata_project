import 'package:json_annotation/json_annotation.dart';

part 'market_news.g.dart';

@JsonSerializable(explicitToJson: true)
class MarketModel {
  MarketModel(this.related, this.category, this.url, this.image, this.datetime,
      this.headline, this.source, this.summary,
      {required this.id});
  final int id, datetime;
  final String category, headline, image, related, source, summary, url;
  factory MarketModel.fromJson(Map<String, dynamic> json) =>
      _$MarketModelFromJson(json);
  Map<String, dynamic> toJson() => _$MarketModelToJson(this);
}
