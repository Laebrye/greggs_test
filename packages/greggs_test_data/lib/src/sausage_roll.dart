import 'package:freezed_annotation/freezed_annotation.dart';

part 'sausage_roll.g.dart';
part 'sausage_roll.freezed.dart';

/// Class object for sausage roll. Would normally implement most functionality
/// with freezed or equatable
@freezed
class SausageRoll with _$SausageRoll {
  factory SausageRoll({
    required String articleCode,
    required String shopCode,
    required DateTime availableFrom,
    required DateTime availableUntil,
    required double eatOutPrice,
    required String articleName,
    required List<String> dayParts,
    required String internalDescription,
    required String customerDescription,
    required String imageUri,
    required String thumbnailUri,
  }) = _SausageRoll;

  factory SausageRoll.fromJson(Map<String, dynamic> json) =>
      _$SausageRollFromJson(json);
}
