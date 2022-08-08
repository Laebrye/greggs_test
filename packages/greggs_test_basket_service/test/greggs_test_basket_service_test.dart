import 'package:greggs_test_basket_service/greggs_test_basket_service.dart';
import 'package:greggs_test_data_models/greggs_test_data_models.dart';
import 'package:test/test.dart';

/// I'll admit these tests are a little shaky - each of them has to pass in turn.
/// With more time I'd look more carefully at setUp/tearDown functions

void main() {
  group('Basket update tests', () {
    final service = GreggsTestBasketService();
    final sausageRoll = SausageRoll(
      articleCode: '00000',
      articleName: 'sausage_roll',
      availableFrom: DateTime.now().subtract(const Duration(seconds: 1)),
      availableUntil: DateTime.now().add(const Duration(seconds: 1)),
      customerDescription: '',
      dayParts: [],
      eatOutPrice: 0.5,
      imageUri: '',
      internalDescription: '',
      shopCode: '',
      thumbnailUri: '',
    );

    setUp(() {
      // Additional setup goes here.
    });

    test('Basket returned unmodified if empty and item removal attmpeted', () {
      expect(service.basketSubject.value.contents.isEmpty, isTrue);
      service.removeFromBasket(sausageRoll);
      expect(service.basketSubject.value.contents.isEmpty, isTrue);
    });

    test('Can add to basket if basket is empty', () {
      expect(service.basketSubject.value.contents.isEmpty, isTrue);
      service.addToBasket(sausageRoll);
      expect(service.basketSubject.value.contents[sausageRoll.getArticleCode()],
          1);
    });

    test('Can add to basket if basket is not empty', () {
      expect(service.basketSubject.value.contents[sausageRoll.getArticleCode()],
          1);
      service.addToBasket(sausageRoll);
      expect(service.basketSubject.value.contents[sausageRoll.getArticleCode()],
          2);
    });

    test('Can remove from basket if basket and basket is updated accordingly',
        () {
      expect(service.basketSubject.value.contents[sausageRoll.getArticleCode()],
          2);
      service.removeFromBasket(sausageRoll);
      expect(service.basketSubject.value.contents[sausageRoll.getArticleCode()],
          1);
    });
  });
}
