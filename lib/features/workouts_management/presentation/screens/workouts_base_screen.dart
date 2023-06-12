import 'package:flutter/material.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/features/workouts_management/utils/workouts_route_generator.dart';

class WorkoutsBaseScreen extends StatefulWidget {
  const WorkoutsBaseScreen({super.key});

  @override
  State<WorkoutsBaseScreen> createState() => _WorkoutsBaseScreenState();
}

class _WorkoutsBaseScreenState extends State<WorkoutsBaseScreen>
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
        key: Constants.workoutsNavigtorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (_) => WorkoutsRouteGenerator.generateRoute(settings));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
