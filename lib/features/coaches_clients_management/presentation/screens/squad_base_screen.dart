import 'package:flutter/material.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/features/coaches_clients_management/utils/squad_route_generator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SquadBaseScreen extends StatefulWidget {
  const SquadBaseScreen({super.key});

  @override
  State<SquadBaseScreen> createState() => _SquadBaseScreenState();
}

class _SquadBaseScreenState extends State<SquadBaseScreen>
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
        key: Constants.squadNavigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (_) => SafeArea(
                  minimum: EdgeInsets.fromLTRB(0.w, 2.h, 0.w, 2.h),
                  child: SquadRouteGenerator.generateRoute(settings)));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
