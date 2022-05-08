import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quiver/core.dart';

part 'market_news.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class MarketModel {
  const MarketModel(this.related, this.category, this.url, this.image, this.datetime,
      this.headline, this.source, this.summary,
      {required this.id});

  factory MarketModel.fromJson(Map<String, dynamic> json) =>
      _$MarketModelFromJson(json);

  final int id, datetime;
  final String category, headline, image, related, source, summary, url;

  Map<String, dynamic> toJson() => _$MarketModelToJson(this);

  @override
  bool operator ==(Object other) =>
      // ignore: avoid_bool_literals_in_conditional_expressions
      (other is MarketModel) ? (
        id == other.id && 
        datetime == other.datetime &&
        category == other.category &&
        headline == other.headline &&
        image == other.image &&
        related == other.related &&
        source == other.source &&
        summary == other.summary &&
        url == other.url
      ) : false;

  @override
  int get hashCode => hashObjects([
    id, datetime, category, headline, image, related, source, summary]);
}
