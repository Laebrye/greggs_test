// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sausage_roll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SausageRoll _$$_SausageRollFromJson(Map<String, dynamic> json) =>
    _$_SausageRoll(
      articleCode: json['articleCode'] as String,
      shopCode: json['shopCode'] as String,
      availableFrom: DateTime.parse(json['availableFrom'] as String),
      availableUntil: DateTime.parse(json['availableUntil'] as String),
      eatInPrice: (json['eatInPrice'] as num).toDouble(),
      eatOutPrice: (json['eatOutPrice'] as num).toDouble(),
      articleName: json['articleName'] as String,
      dayParts:
          (json['dayParts'] as List<dynamic>).map((e) => e as String).toList(),
      internalDescription: json['internalDescription'] as String,
      customerDescription: json['customerDescription'] as String,
      imageUri: json['imageUri'] as String,
      thumbnailUri: json['thumbnailUri'] as String,
    );

Map<String, dynamic> _$$_SausageRollToJson(_$_SausageRoll instance) =>
    <String, dynamic>{
      'articleCode': instance.articleCode,
      'shopCode': instance.shopCode,
      'availableFrom': instance.availableFrom.toIso8601String(),
      'availableUntil': instance.availableUntil.toIso8601String(),
      'eatInPrice': instance.eatInPrice,
      'eatOutPrice': instance.eatOutPrice,
      'articleName': instance.articleName,
      'dayParts': instance.dayParts,
      'internalDescription': instance.internalDescription,
      'customerDescription': instance.customerDescription,
      'imageUri': instance.imageUri,
      'thumbnailUri': instance.thumbnailUri,
    };
