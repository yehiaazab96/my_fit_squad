import 'package:my_fit_squad/features/base/data/helpers/navigation_bar_items.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/navigation_page_view_model.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/network_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final isConnectedProvider =
    StateNotifierProvider<NetworkViewModel, bool>((ref) {
  return NetworkViewModel();
});

final currentPageProvider =
    StateNotifierProvider<NavigationPageViewModel, NavigationBarItem>((ref) {
  return NavigationPageViewModel();
});

final deviceWidth = Provider<double>((ref) {
  return Device.width;
});
