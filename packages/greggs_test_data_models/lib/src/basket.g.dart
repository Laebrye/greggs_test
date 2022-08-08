// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Basket _$$_BasketFromJson(Map<String, dynamic> json) => _$_Basket(
      basketId: json['basketId'] as String,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      contents: Map<String, int>.from(json['contents'] as Map),
    );

Map<String, dynamic> _$$_BasketToJson(_$_Basket instance) => <String, dynamic>{
      'basketId': instance.basketId,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'contents': instance.contents,
    };
