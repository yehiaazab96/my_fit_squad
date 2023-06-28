import 'package:flutter/material.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/features/home/utils/home_route_generator.dart';

class HomeBaseScreen extends StatefulWidget {
  const HomeBaseScreen({super.key});

  @override
  State<HomeBaseScreen> createState() => _HomeBaseScreenState();
}

class _HomeBaseScreenState extends State<HomeBaseScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Expanded(
      child: Navigator(
        key: Constants.homeNavigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (_) => HomeRouteGenerator.generateRoute(settings));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
