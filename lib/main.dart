import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:greggs_test_basket_service/greggs_test_basket_service.dart';
import 'package:greggs_test_catalogue_service/greggs_test_catalogue_service.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

final getIt = GetIt.instance;

void main() async {
  getIt.registerSingleton<GreggsTestBaseBasketService>(
      GreggsTestBasketService());
  getIt.registerSingleton<GreggsTestBaseCatalogueService>(
      GreggsTestCatalogueService());

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}
