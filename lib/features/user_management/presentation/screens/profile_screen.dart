import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/extensions/widget_extensions.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/common/injection/squad_injection_container.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_network_image.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:my_fit_squad/features/user_management/presentation/screens/assign_program_screen.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/entities/program_details_args.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/program_details_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/program_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = './profile_screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    fetchProfile();
    super.initState();
  }

  void fetchProfile() {
    Future.delayed(0.seconds, () {
      ProviderScope.containerOf(context)
          .read(profileViewModelProvider.notifier)
          .getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.symmetric(vertical: 2.h, horizontal: 0.w),
      child: Consumer(builder: (_, ref, __) {
        var user = ref.watch(userProvider);
        var clients = ref.watch(clientsViewModelProvider).data.clients;
        List<User> potentialClients = [];
        List<User> coachClients = [];

        if (user != null && user.joinRequests != null) {
          potentialClients = clients
              .where((element) => user.joinRequests!.contains(element.userId))
              .toList();
        }
        if (user != null && user.clients != null) {
          coachClients = clients
              .where((element) => user.clients!.contains(element.userId))
              .toList();
        }
        print(potentialClients);
        return RefreshIndicator(
          onRefresh: () {
            fetchProfile();
            return Future.delayed(1.seconds);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 8.h,
                  child: ClipOval(
                    child: SizedBox(
                      width: 16.h,
                      height: 16.h,
                      child: AppNetworkImage(
                        url: user?.profileImage ?? '',
                        hasToken: true,
                      ),
                    ),
                  ),
                ).paddingBottom(2.h),
                Text(
                  "${user?.firstName ?? ""} ${user?.lastName ?? ''}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (user?.code != null && user!.code!.isNotEmpty)
                  Column(
                    children: [
                      AppCard(
                        externalPadding: EdgeInsets.symmetric(horizontal: 25.w),
                        internalPadding: EdgeInsets.symmetric(
                            vertical: 2.w, horizontal: 1.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  user.code ?? "",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const Icon(
                                  Icons.copy,
                                  size: 16,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Invite people to your squad using this code",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                Divider(
                  thickness: 1,
                  indent: 5.w,
                  endIndent: 5.w,
                ).paddingVertical(2.h),
                if (user != null && user.role?.toLowerCase() == 'client')
                  SizedBox(
                    height: 25.h,
                    child: AppCard(
                      internalPadding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Program',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                'you currently active program',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ).paddingBottom(1.h),
                          if (user.currentProgram != null &&
                              user.currentProgram!.program != null &&
                              user.currentProgram!.program!.classes!.isNotEmpty)
                            Expanded(
                                child: ProgramWidget(
                              program: user.currentProgram!.program,
                              onTap: () {
                                ref
                                    .watch(profileViewModelProvider.notifier)
                                    .navigateTo(ProgramDetailsScreen.routeName,
                                        arguments: ProgramDetailsArgs(
                                            program:
                                                user.currentProgram!.program,
                                            startDateString: user
                                                .currentProgram!.startDate));
                              },
                            )),
                        ],
                      ),
                    ),
                  ),
                if (user != null && user.role?.toLowerCase() == 'client')
                  SizedBox(
                    height: 25.h,
                    child: AppCard(
                      internalPadding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'History',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                'Your previous programs',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ).paddingBottom(1.h),
                          Expanded(
                            child: ListView.builder(
                              itemCount: user.programsHistory?.length,
                              itemBuilder: (context, index) {
                                return ProgramWidget(
                                  program: user.programsHistory?[index],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (user != null && user.role?.toLowerCase() != 'client')
                  SizedBox(
                    height: 25.h,
                    child: AppCard(
                      internalPadding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Squad',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                '${user.clients?.length ?? 0} out of ${user.subscribtionPlan?.clients.toInt() ?? 0}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ).paddingBottom(1.h),
                          Expanded(
                            child: ListView.builder(
                              itemCount: coachClients.length,
                              itemBuilder: (context, index) {
                                return AppCard(
                                  externalPadding: EdgeInsets.zero,
                                  color: Theme.of(context).colorScheme.scrim,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 3.h,
                                        child: ClipOval(
                                          child: SizedBox(
                                            width: 10.h,
                                            child: AppNetworkImage(
                                                hasToken: true,
                                                url: coachClients[index]
                                                        .profileImage ??
                                                    ''),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${coachClients[index].firstName ?? ''} ${coachClients[index].lastName ?? ''}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                coachClients[index]
                                                        .currentProgram
                                                        ?.program
                                                        ?.title ??
                                                    'No Assigned Program',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    ref
                                                        .watch(
                                                            profileViewModelProvider
                                                                .notifier)
                                                        .navigateTo(
                                                            AssignProgramScreen
                                                                .routeName,
                                                            arguments:
                                                                coachClients[
                                                                    index]);
                                                  },
                                                  child: Text(
                                                    coachClients[index]
                                                                .currentProgram!
                                                                .program!
                                                                .title !=
                                                            null
                                                        ? 'Change'
                                                        : 'Assign',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (user != null && user.role?.toLowerCase() != 'client')
                  SizedBox(
                    height: 25.h,
                    child: AppCard(
                      internalPadding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Join Requests',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                'Requests to join your squad',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ).paddingBottom(1.h),
                          Expanded(
                            child: ListView.builder(
                              itemCount: potentialClients.length,
                              itemBuilder: (context, index) {
                                return AppCard(
                                  externalPadding: EdgeInsets.zero,
                                  color: Theme.of(context).colorScheme.scrim,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${potentialClients[index].firstName ?? ''} ${potentialClients[index].lastName ?? ''}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          Text(
                                            'Age ${potentialClients[index].age ?? ''}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            children: [
                                              ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    foregroundColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .primary),
                                                onPressed: () {
                                                  ref
                                                      .watch(
                                                          coachesViewModelProvider
                                                              .notifier)
                                                      .respondToJoinRequest(
                                                          respond: true,
                                                          cliendID:
                                                              potentialClients[
                                                                      index]
                                                                  .userId);
                                                },
                                                icon: const Icon(Icons.check),
                                                label: const Text('Accept'),
                                              ),
                                              ElevatedButton.icon(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          foregroundColor: Theme
                                                                  .of(context)
                                                              .colorScheme
                                                              .errorContainer),
                                                  onPressed: () {
                                                    ref
                                                        .watch(
                                                            coachesViewModelProvider
                                                                .notifier)
                                                        .respondToJoinRequest(
                                                            respond: false,
                                                            cliendID:
                                                                potentialClients[
                                                                        index]
                                                                    .userId);
                                                  },
                                                  icon: const Icon(
                                                      Icons.remove_circle),
                                                  label: const Text('Decline')),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Container(
                  width: 100.w,
                  height: 5.h,
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  child: ElevatedButton(
                    child: Text("Log out".tr(),
                        style: Theme.of(context).textTheme.bodyMedium),
                    onPressed: () {
                      ProviderScope.containerOf(context)
                          .read(userProvider.notifier)
                          .signout();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
