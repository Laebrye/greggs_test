import 'package:flutter/material.dart';
import 'package:greggs_test_basket_service/greggs_test_basket_service.dart';
import 'package:greggs_test_data_models/greggs_test_data_models.dart';

import '../../main.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BasketSummary extends StatelessWidget {
  const BasketSummary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Material(
        child: Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16) +
              const EdgeInsets.only(bottom: 24),
          width: double.maxFinite,
          alignment: Alignment.topCenter,
          child: StreamBuilder<Basket>(
            stream: getIt<GreggsTestBaseBasketService>().getBasketStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ErrorWidget(
                    snapshot.error ?? Exception('Oops - something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final count = (snapshot.data?.contents.isEmpty ?? true)
                  ? 0
                  : snapshot.data!.contents.values
                      .reduce((value, element) => value + element);
              return SizedBox(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
