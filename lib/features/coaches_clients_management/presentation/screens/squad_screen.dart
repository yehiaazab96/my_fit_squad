import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/constants/colors.dart';
import 'package:my_fit_squad/common/injection/squad_injection_container.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SquadScreen extends StatefulWidget {
  static const routeName = 'squad_screen';
  const SquadScreen({super.key});

  @override
  State<SquadScreen> createState() => _SquadScreenState();
}

class _SquadScreenState extends State<SquadScreen> {
  @override
  void initState() {
    Future.delayed(0.seconds, () {
      ProviderScope.containerOf(context)
          .read(coachesViewModelProvider.notifier)
          .getCoaches();
      ProviderScope.containerOf(context)
          .read(clientsViewModelProvider.notifier)
          .getClients();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer(builder: (_, ref, __) {
          var coaches = ref.watch(coachesViewModelProvider).data.coaches;
          var clients = ref.watch(clientsViewModelProvider).data.clients;

          print(coaches);
          print(clients);

          return AppCard(
            child: Column(
              children: coaches
                  .map((e) => Container(
                        height: 5.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.w),
                            color:
                                Theme.of(context).colorScheme.inverseSurface),
                      ))
                  .toList(),
            ),
          );
        })
      ],
    );
  }
}
