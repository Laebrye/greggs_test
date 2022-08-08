import 'package:greggs_test_data_models/greggs_test_data_models.dart';
import 'package:test/test.dart';

void main() {
  group('Test that Sausage Roll can be instantiated', () {
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

    test('First Test', () {
      expect(sausageRoll, isA<SausageRoll>());
    });
  });
}
