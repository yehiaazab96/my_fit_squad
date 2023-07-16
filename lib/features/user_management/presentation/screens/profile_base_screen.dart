import 'package:flutter/material.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/features/user_management/utils/profile_route_generator.dart';

class ProfileBaseScreen extends StatefulWidget {
  const ProfileBaseScreen({super.key});

  @override
  State<ProfileBaseScreen> createState() => _ProfileBaseScreenState();
}

class _ProfileBaseScreenState extends State<ProfileBaseScreen>
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
        key: Constants.profileNavigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (_) => ProfileRouteGenrator.generateRoute(settings));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
