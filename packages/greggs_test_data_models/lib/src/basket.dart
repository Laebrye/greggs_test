import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greggs_test_data_models/greggs_test_data_models.dart';

part 'basket.g.dart';
part 'basket.freezed.dart';

@freezed
class Basket with _$Basket {
  const Basket._();
  factory Basket({
    required String basketId,
    required DateTime lastUpdated,
    required Map<String, int> contents,
  }) = _Basket;

  factory Basket.fromJson(Map<String, dynamic> json) => _$BasketFromJson(json);

  Basket withItemRemoved(GreggsTestProduct product) {
    final code = product.getArticleCode();
    Map<String, int> updatedContents = Map<String, int>.from(contents);
    if (!updatedContents.containsKey(code)) {
      return this;
    }
    if (updatedContents[code] == 1) {
      updatedContents.remove(code);
    } else {
      updatedContents[code] = updatedContents[code]! - 1;
    }
    return copyWith(contents: updatedContents);
  }

  Basket withItemAdded(GreggsTestProduct product) {
    final code = product.getArticleCode();
    Map<String, int> updatedContents = Map<String, int>.from(contents);
    updatedContents[code] = (updatedContents[code] ?? 0) + 1;
    return copyWith(contents: updatedContents);
  }
}
