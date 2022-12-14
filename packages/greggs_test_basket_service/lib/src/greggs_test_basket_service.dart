import 'package:rxdart/rxdart.dart';

import 'package:greggs_test_data_models/greggs_test_data_models.dart';

abstract class GreggsTestBaseBasketService {
  Future<void> addToBasket(GreggsTestProduct product);
  Future<void> removeFromBasket(GreggsTestProduct product);
  Stream<Basket> getBasketStream();
  Future<void> changeEatingInPreference(bool newPreference);
  dispose();
}

class GreggsTestBasketService implements GreggsTestBaseBasketService {
  final Basket? initialBasket;
  GreggsTestBasketService({
    this.initialBasket,
  });

  late final BehaviorSubject<Basket> basketSubject =
      BehaviorSubject<Basket>.seeded(initialBasket ??
          Basket(
            basketId: '000001',
            contents: {},
            lastUpdated: DateTime.now(),
            eatingIn: false,
          ));

  @override
  Future<void> addToBasket(GreggsTestProduct product) async {
    final current = basketSubject.value;
    final updated = current.withItemAdded(product);
    basketSubject.add(updated);
  }

  @override
  Future<void> removeFromBasket(GreggsTestProduct product) async {
    final current = basketSubject.value;
    final updated = current.withItemRemoved(product);
    basketSubject.add(updated);
  }

  @override
  Stream<Basket> getBasketStream() => basketSubject.stream;

  @override
  dispose() {
    basketSubject.close();
  }

  @override
  Future<void> changeEatingInPreference(bool newPreference) async {
    final updated = basketSubject.value.copyWith(eatingIn: newPreference);
    basketSubject.add(updated);
  }
}
