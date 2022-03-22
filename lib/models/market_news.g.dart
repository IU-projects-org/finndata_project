// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketModel _$MarketModelFromJson(Map<String, dynamic> json) => MarketModel(
      json['related'] as String,
      json['category'] as String,
      json['url'] as String,
      json['image'] as String,
      json['datetime'] as int,
      json['headline'] as String,
      json['source'] as String,
      json['summary'] as String,
      id: json['id'] as int,
    );

Map<String, dynamic> _$MarketModelToJson(MarketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'datetime': instance.datetime,
      'category': instance.category,
      'headline': instance.headline,
      'image': instance.image,
      'related': instance.related,
      'source': instance.source,
      'summary': instance.summary,
      'url': instance.url,
    };
