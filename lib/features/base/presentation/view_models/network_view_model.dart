import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkViewModel extends StateNotifier<bool> {
  NetworkViewModel() : super(true);

  void listenToNetworkChanges() async {
    InternetConnectionChecker checker = InternetConnectionChecker();
    // checker.checkInterval = const Duration(seconds: 5);
    checker.onStatusChange.listen((status) {
      state = status == InternetConnectionStatus.connected;
      print('$state isconnected');
    });
  }

  void setState(bool isConnected) {
    state = isConnected;
  }
}
