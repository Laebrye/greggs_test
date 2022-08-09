import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:greggs_test_basket_service/greggs_test_basket_service.dart';
import 'package:greggs_test_catalogue_service/greggs_test_catalogue_service.dart';
import 'package:greggs_test_data_models/greggs_test_data_models.dart';

import '../../main.dart';
import '../settings/settings_view.dart';
import 'basket_view.dart';

/// Displays a list of items from the catalogue.
class CounterView extends StatefulWidget {
  const CounterView({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Greggs Test'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<GreggsTestProduct>>(
              future: getIt<GreggsTestBaseCatalogueService>().fetchCatalogue(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return ErrorWidget(snapshot.error ??
                      Exception(
                        "Oops! Something wnet wrong",
                      ));
                }
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ProductCatalogueItem(product: snapshot.data![index]);
                  },
                  itemCount: snapshot.data!.length,
                );
              },
            ),
          ),
          const BasketSummary(),
        ],
      ),
    );
  }
}

class ProductCatalogueItem extends StatelessWidget {
  const ProductCatalogueItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final GreggsTestProduct product;

  @override
  Widget build(BuildContext context) {
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
                    product.getInternalDescription(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  CachedNetworkImage(
                    imageUrl: product.getThumbnailUri(),
                    width: 75,
                    height: 75,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              const SizedBox(
                width: 4,
              ),
              ElevatedButton.icon(
                onPressed: () =>
                    getIt<GreggsTestBaseBasketService>().addToBasket(product),
                icon: const Icon(Icons.add),
                label: const Text('Add to cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
