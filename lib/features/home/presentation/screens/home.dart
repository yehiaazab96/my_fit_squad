import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';
import 'package:my_fit_squad/common/extensions/widget_extensions.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/common/utils/health_info.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_loader.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_network_image.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/column_row.dart';
import 'package:my_fit_squad/features/home/presentation/widgets/category_container.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
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
    Future.delayed(0.seconds, () async {
      ProviderScope.containerOf(context)
          .read(categoriesViewModelProvider.notifier)
          .getCategories();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // HealthInfo.getHeatldataforDuartion(
    //     duartion: Duration(hours: DateTime.now().hour),
    //     dataTypes: [
    //       HealthDataType.STEPS,
    //       HealthDataType.BASAL_ENERGY_BURNED,
    //       HealthDataType.ACTIVE_ENERGY_BURNED,
    //       HealthDataType.DISTANCE_WALKING_RUNNING,
    //       HealthDataType.HEART_RATE
    //     ]);

    return SafeArea(
      minimum: EdgeInsets.symmetric(vertical: 2.h, horizontal: 0.w),
      child: SingleChildScrollView(
        child: ColumnRow(
            breakPoint: 800,
            // columnMainAxisAlignment: MainAxisAlignment.start,
            children: [
              Consumer(builder: (_, ref, __) {
                var user = ref.watch(userProvider);
                return Card(
                  child: Container(
                    width: 100.w,
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 2.5.h,
                          child: ClipOval(
                            child: SizedBox(
                              width: 10.h,
                              height: 10.h,
                              child: AppNetworkImage(
                                hasToken: true,
                                url: user?.profileImage ?? '',
                              ),
                            ),
                          ),
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
                                    ? (user?.currentProgram?.program?.title ??
                                        '')
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
              CoolHealthDataWidget(),
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
                            : [
                                SizedBox(height: 20.h, child: const AppLoader())
                              ]),
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
            ]),
      ),
    );
  }
}

class CoolHealthDataWidget extends StatefulWidget {
  CoolHealthDataWidget();

  @override
  State<CoolHealthDataWidget> createState() => _CoolHealthDataWidgetState();
}

class _CoolHealthDataWidgetState extends State<CoolHealthDataWidget> {
  List<HealthDataPoint> healthList = [];

  Future getHealthData() async {
    healthList = await HealthInfo.getHeatldataforDuartion(
        duartion: Duration(days: 10.days.inDays),
        dataTypes: [
          HealthDataType.STEPS,
          HealthDataType.BASAL_ENERGY_BURNED,
          HealthDataType.ACTIVE_ENERGY_BURNED,
          HealthDataType.DISTANCE_WALKING_RUNNING,
          HealthDataType.HEART_RATE
        ]);

    return healthList;
  }

  @override
  Widget build(BuildContext context) {
    var steps = 0;
    var healthRate = 0;
    var distance = 0;
    var calories = 0;
    print(healthList);
    if (healthList.isNotEmpty) {
      if (healthList
          .where((element) => element.type == HealthDataType.STEPS)
          .isNotEmpty) {
        steps = double.parse(healthList
                .firstWhere((element) => element.type == HealthDataType.STEPS)
                .value
                .toString())
            .toInt();
        print(steps);
      }
      if (healthList
          .where((element) =>
              element.type == HealthDataType.DISTANCE_WALKING_RUNNING)
          .isNotEmpty) {
        distance = double.parse(healthList
                .firstWhere((element) =>
                    element.type == HealthDataType.DISTANCE_WALKING_RUNNING)
                .value
                .toString())
            .toInt();
        print(distance);
      }
      if (healthList
          .where(
              (element) => element.type == HealthDataType.ACTIVE_ENERGY_BURNED)
          .isNotEmpty) {
        calories = double.parse(healthList
                .firstWhere((element) =>
                    element.type == HealthDataType.ACTIVE_ENERGY_BURNED)
                .value
                .toString())
            .toInt();
        print(calories);
      }
      if (healthList
          .where((element) => element.type == HealthDataType.HEART_RATE)
          .isNotEmpty) {
        healthRate = double.parse(healthList
                .firstWhere(
                    (element) => element.type == HealthDataType.HEART_RATE)
                .value
                .toString())
            .toInt();
        print(healthRate);
      }

      // calories = double.parse(healthList
      //         .firstWhere((element) =>
      //             element.type == HealthDataType.ACTIVE_ENERGY_BURNED)
      //         .value
      //         .toString())
      //     .toInt();
      // print(calories);
    }

    return AppCard(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.transparent,
              blurRadius: 6.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Health Data',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                    onPressed: () {
                      getHealthData().then((value) {
                        setState(() {});
                      });
                    },
                    icon: Icon(Icons.refresh),
                    label: Text('Refresh'))
              ],
            ),
            SizedBox(height: 16.0),
            if (healthList.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildDataRow(
                        Icons.directions_walk, 'Step Count', '${steps}'),
                  ),
                  Expanded(
                      child: _buildDataRow(
                          Icons.favorite, 'Heart Rate', '${healthRate} bpm')),
                ],
              ),
            if (healthList.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildDataRow(
                        Icons.whatshot, 'Calories Burned', '${calories} kcal'),
                  ),
                  Expanded(
                      child: _buildDataRow(
                          Icons.whatshot, 'Distance', '${distance} meters')),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(IconData icon, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 30.0,
        ),
        SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
