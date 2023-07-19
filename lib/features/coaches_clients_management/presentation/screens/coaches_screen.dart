import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/extensions/widget_extensions.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/common/injection/squad_injection_container.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_network_image.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CoachesScreen extends StatefulWidget {
  static const routeName = 'coaches_full_screen';
  const CoachesScreen({super.key});

  @override
  State<CoachesScreen> createState() => _CoachesScreenState();
}

class _CoachesScreenState extends State<CoachesScreen> {
  @override
  void initState() {
    Future.delayed(0.seconds, () {
      ProviderScope.containerOf(context)
          .read(coachesViewModelProvider.notifier)
          .getCoaches();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Consumer(builder: (_, ref, __) {
            var coaches = ref.watch(coachesViewModelProvider).data.coaches;
            return Expanded(
              child: AppCard(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Coaches",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ).paddingBottom(1.h),
                  Expanded(
                    child: ListView(
                      children: coaches
                          .map((e) => Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3.h, horizontal: 2.w),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 3.h,
                                      child: ClipOval(
                                        child: SizedBox(
                                          width: 10.h,
                                          child: AppNetworkImage(
                                            hasToken: true,
                                            url: e.profileImage ?? '',
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${e.firstName ?? ''} ${e.lastName ?? ''}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium),
                                          RatingBar.builder(
                                            initialRating: 4,
                                            minRating: 1,
                                            ignoreGestures: true,
                                            direction: Axis.horizontal,
                                            itemCount: 5,
                                            itemSize: 2.h,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                            onRatingUpdate: (rating) {},
                                          )
                                        ],
                                      ),
                                    ),
                                    Consumer(builder: (_, ref, __) {
                                      var user = ref.watch(userProvider);

                                      var requestPending = (ref
                                              .watch(userProvider)
                                              ?.requestPending ??
                                          false);

                                      return !requestPending
                                          ? Expanded(
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    ref
                                                        .watch(
                                                            clientsViewModelProvider
                                                                .notifier)
                                                        .requestToJoinSquad(
                                                            coachID: e.userId,
                                                            status:
                                                                !(requestPending),
                                                            onreturn: () {
                                                              setState(() {});
                                                            });
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          (requestPending)
                                                              ? Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onTertiary
                                                              : Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary),
                                                  child: Text(
                                                          (requestPending)
                                                              ? 'Cancel'
                                                              : 'Join',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium)
                                                      .paddingVertical(0.5.h)),
                                            )
                                          : (e.joinRequests != null &&
                                                  e.joinRequests!
                                                      .contains(user?.userId))
                                              ? Expanded(
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        ref
                                                            .watch(
                                                                clientsViewModelProvider
                                                                    .notifier)
                                                            .requestToJoinSquad(
                                                                coachID:
                                                                    e.userId,
                                                                status:
                                                                    !(requestPending),
                                                                onreturn: () {
                                                                  setState(
                                                                      () {});
                                                                });
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor: (requestPending)
                                                              ? Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onTertiary
                                                              : Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary),
                                                      child: Text(
                                                              (requestPending)
                                                                  ? 'Cancel'
                                                                  : 'Join',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleMedium)
                                                          .paddingVertical(
                                                              0.5.h)),
                                                )
                                              : SizedBox();
                                    })
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              )),
            );
          }),
        ],
      ),
    );
  }
}
