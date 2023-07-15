import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import 'package:my_fit_squad/common/api/api_urls.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/common/utils/health_info.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_loader.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/column_row.dart';
import 'package:my_fit_squad/features/home/presentation/widgets/category_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = './home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(0.seconds, () {
      ProviderScope.containerOf(context)
          .read(categoriesViewModelProvider.notifier)
          .getCategories();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HealthInfo.getHeatldataforDuartion(
        duartion: Duration(days: 1), dataTypes: [HealthDataType.STEPS]);
    return SafeArea(
      minimum: EdgeInsets.symmetric(vertical: 2.h, horizontal: 0.w),
      child: ColumnRow(
          breakPoint: 800,
          // columnMainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(builder: (_, ref, __) {
              var user = ref.watch(userProvider);
              return Card(
                child: Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        foregroundImage: NetworkImage(
                            '${ApiUrls.baseImageUrl}${ApiUrls.users}/${user?.profileImage ?? ''}'),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Welcome back , ${user?.firstName}'),
                          if (user?.role == 'client')
                            Text(
                              user?.currentProgram != null
                                  ? (user?.currentProgram?.program?.title ?? '')
                                  : 'There is no program assigned',
                              style: TextStyle(fontSize: 16),
                            ),
                          if (user?.role == 'admin')
                            Text(
                              '${user?.subscribtionPlan?.title ?? ''} : ${user?.clients?.length ?? 0} out of ${user?.subscribtionPlan?.clients.toInt() ?? 1} Clients',
                              style: TextStyle(fontSize: 16),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
            Consumer(builder: (_, ref, __) {
              var notifer = ref.watch(categoriesViewModelProvider.notifier);
              var categories =
                  ref.watch(categoriesViewModelProvider).data.categories;
              var currentSelectedCategory = ref
                  .watch(categoriesViewModelProvider)
                  .data
                  .currentSelectedCategory;
              var navigationNotifer = ref.watch(currentPageProvider.notifier);
              return Card(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  width: 100.w,
                  child: Wrap(
                      children: categories.isNotEmpty
                          ? categories
                              .map((e) => CategoryContainer(
                                    borderRadius: e.borderRadius,
                                    child: e.image,
                                    onTap: () {
                                      if (currentSelectedCategory != e) {
                                        notifer
                                            .changeCurrentSelectedCategory(e);
                                      }
                                      navigationNotifer.setCurrentIndex(1);
                                    },
                                  ))
                              .toList()
                          : [SizedBox(height: 20.h, child: const AppLoader())]),
                ),
              );
            }),
            Container(
              width: 100.w,
              height: 5.h,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              child: ElevatedButton(
                child: Text("browse_all_workouts".tr(),
                    style: Theme.of(context).textTheme.bodyMedium),
                onPressed: () {
                  ProviderScope.containerOf(context)
                      .read(currentPageProvider.notifier)
                      .setCurrentIndex(1);
                },
              ),
            ),
            Container(
              width: 100.w,
              height: 5.h,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              child: ElevatedButton(
                child: Text("log out".tr(),
                    style: Theme.of(context).textTheme.bodyMedium),
                onPressed: () {
                  ProviderScope.containerOf(context)
                      .read(userProvider.notifier)
                      .signout();
                },
              ),
            ),
          ]),
    );
  }
}
