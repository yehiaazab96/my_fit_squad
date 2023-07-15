import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/api/api_urls.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/extensions/widget_extensions.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/common/injection/squad_injection_container.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_network_image.dart';
import 'package:my_fit_squad/features/coaches_clients_management/presentation/screens/coaches_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SquadScreen extends StatefulWidget {
  static const routeName = 'squad_screen';
  const SquadScreen({super.key});

  @override
  State<SquadScreen> createState() => _SquadScreenState();
}

class _SquadScreenState extends State<SquadScreen> with BaseViewModel {
  @override
  void initState() {
    Future.delayed(0.seconds, () {
      var user = ProviderScope.containerOf(context).read(userProvider);

      ProviderScope.containerOf(context)
          .read(coachesViewModelProvider.notifier)
          .getCoaches();

      if (user?.role?.toLowerCase() != 'client') {
        ProviderScope.containerOf(context)
            .read(clientsViewModelProvider.notifier)
            .getClients();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer(builder: (_, ref, __) {
          var coaches = ref.watch(coachesViewModelProvider).data.coaches;
          print(coaches);
          return SizedBox(
            height: 35.h,
            child: AppCard(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Coaches",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateToScreenNamed(CoachesScreen.routeName,
                            navigatorKey: Constants.squadNavigatorKey);
                      },
                      child: Text(
                        "View All",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ).paddingBottom(1.h),
                Expanded(
                  child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0.h,
                          childAspectRatio: 0.9,
                          mainAxisSpacing: 0.h),
                      children: coaches.map((coach) {
                        return AppCard(
                            externalPadding: const EdgeInsets.all(0),
                            internalPadding: const EdgeInsets.all(0),
                            borderRadius: BorderRadius.circular(1.h),
                            borderColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            child: Stack(
                              children: [
                                Positioned(
                                    child: Container(
                                  height: 7.h,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(1.h),
                                          topRight: Radius.circular(1.h))),
                                )),
                                Positioned.fill(
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 5.h,
                                        child: ClipOval(
                                          child: SizedBox(
                                            width: 10.h,
                                            child: AppNetworkImage(
                                              url:
                                                  '${ApiUrls.baseImageUrl}${ApiUrls.users}/${coach.profileImage ?? ''}',
                                            ),
                                          ),
                                        ),
                                      ).paddingVertical(2.h),
                                      Text(
                                        "${coach.firstName ?? ""} ${coach.lastName ?? ''}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ));
                      }).toList()),
                ),
              ],
            )),
          );
        }),
        Consumer(builder: (_, ref, __) {
          var user = ref.watch(userProvider);
          var clients = ref.watch(clientsViewModelProvider).data.clients;
          print(user?.role?.toLowerCase());
          return user?.role?.toLowerCase() != 'client'
              ? SizedBox(
                  height: 35.h,
                  child: AppCard(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Clients",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            "View All",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    decoration: TextDecoration.underline),
                          ),
                        ],
                      ).paddingBottom(1.h),
                      Expanded(
                        child: GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 0.h,
                                    childAspectRatio: 0.9,
                                    mainAxisSpacing: 0.h),
                            children: clients
                                .map((client) => AppCard(
                                    externalPadding: const EdgeInsets.all(0),
                                    internalPadding: const EdgeInsets.all(0),
                                    borderRadius: BorderRadius.circular(1.h),
                                    borderColor:
                                        Theme.of(context).colorScheme.secondary,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            child: Container(
                                          height: 7.h,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                                  .withOpacity(0.5),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(1.h),
                                                  topRight:
                                                      Radius.circular(1.h))),
                                        )),
                                        Positioned.fill(
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 5.h,
                                                child: ClipOval(
                                                  child: SizedBox(
                                                    width: 10.h,
                                                    child: AppNetworkImage(
                                                      url:
                                                          '${ApiUrls.baseImageUrl}${ApiUrls.users}/${client.profileImage ?? ''}',
                                                    ),
                                                  ),
                                                ),
                                              ).paddingVertical(2.h),
                                              Text(
                                                "${client.firstName ?? ""} ${client.lastName ?? ''}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )))
                                .toList()),
                      ),
                    ],
                  )),
                )
              : const SizedBox();
        })
      ],
    );
  }
}
