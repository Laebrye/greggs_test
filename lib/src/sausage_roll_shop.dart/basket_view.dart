import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:greggs_test_basket_service/greggs_test_basket_service.dart';
import 'package:greggs_test_data_models/greggs_test_data_models.dart';

import '../../main.dart';

class BasketSummary extends StatelessWidget {
  const BasketSummary({
    required this.products,
    Key? key,
  }) : super(key: key);

  final List<GreggsTestProduct> products;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Basket>(
      stream: getIt<GreggsTestBaseBasketService>().getBasketStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorWidget(
              snapshot.error ?? Exception('Oops - something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final count = (snapshot.data?.contents.isEmpty ?? true)
            ? 0
            : snapshot.data!.contents.values
                .reduce((value, element) => value + element);
        return InkWell(
          onTap: () {
            showMaterialModalBottomSheet(
              context: context,
              builder: ((context) {
                return StreamBuilder<Basket>(
                    stream:
                        getIt<GreggsTestBaseBasketService>().getBasketStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return ErrorWidget(snapshot.error ??
                            Exception('Oops - something went wrong'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Eating in?',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Checkbox(
                                  value: snapshot.data?.eatingIn,
                                  onChanged: (value) =>
                                      getIt<GreggsTestBaseBasketService>()
                                          .changeEatingInPreference(
                                              value ?? false),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Total: £${snapshot.data!.getTotal(products).toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data!.contents.length,
                                itemBuilder: (context, index) =>
                                    BasketLineItemView(
                                  product: products.firstWhereOrNull((prod) =>
                                      prod.getArticleCode() ==
                                      snapshot.data!.contents.keys
                                          .toList()[index]),
                                  quantity: snapshot.data!.contents.values
                                      .toList()[index],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }),
            );
          },
          child: Material(
            child: Container(
                height: 100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16) +
                        const EdgeInsets.only(bottom: 24),
                width: double.maxFinite,
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                scale: animation, child: child);
                          },
                          switchInCurve: Curves.bounceInOut,
                          switchOutCurve: Curves.bounceInOut,
                          child: Material(
                            key: ValueKey<int>(count),
                            shape: const StadiumBorder(),
                            color: const Color(0xff00558F),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 3,
                                horizontal: 6,
                              ),
                              child: Text(
                                count.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      color: const Color(0xffFDB71B),
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.shopping_basket_rounded,
                        color: Color(0xff00558F),
                        size: 40,
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}

class BasketLineItemView extends StatelessWidget {
  const BasketLineItemView({
    Key? key,
    this.product,
    required this.quantity,
  }) : super(key: key);

  final GreggsTestProduct? product;

  final int quantity;

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          alignment: Alignment.topRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product!.getInternalDescription(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  CachedNetworkImage(
                    imageUrl: product!.getThumbnailUri(),
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              const SizedBox(
                width: 4,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => getIt<GreggsTestBaseBasketService>()
                        .removeFromBasket(product!),
                    icon: const Icon(Icons.remove),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(quantity.toString()),
                  const SizedBox(
                    width: 4,
                  ),
                  IconButton(
                    onPressed: () => getIt<GreggsTestBaseBasketService>()
                        .addToBasket(product!),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
