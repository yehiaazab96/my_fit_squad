// import 'package:health/health.dart';

// class HealthInfo {
//   static Future<List<HealthDataPoint>> getHeatldataforDuartion(
//       {Duration? duartion, List<HealthDataType>? dataTypes}) async {
//     HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

//     var types = dataTypes ?? [];

//     bool requested = await health.requestAuthorization(types);

//     var now = DateTime.now();

//     List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
//         now.subtract(duartion ?? Duration.zero), now, types);
//     // print(healthData);

//     List<HealthDataPoint> list = [];

//     var steps = healthData
//         .where((element) => element.type == HealthDataType.STEPS)
//         .toList();
//     steps.sort((a, b) => double.parse(a.value.toString())
//         .compareTo(double.parse(b.value.toString())));
//     // print(steps.last);
//     if (steps.isNotEmpty) {
//       list.add(steps.last);
//     }

//     var distance = healthData
//         .where((element) =>
//             element.type == HealthDataType.DISTANCE_WALKING_RUNNING)
//         .toList();
//     distance.sort((a, b) => double.parse(a.value.toString())
//         .compareTo(double.parse(b.value.toString())));
//     // print(distance.last);
//     if (distance.isNotEmpty) {
//       list.add(distance.last);
//     }

//     var calories = healthData
//         .where((element) => element.type == HealthDataType.ACTIVE_ENERGY_BURNED)
//         .toList();
//     calories.sort((a, b) => double.parse(a.value.toString())
//         .compareTo(double.parse(b.value.toString())));
//     // print(calories.last);
//     if (calories.isNotEmpty) {
//       list.add(calories.last);
//     }

//     var heartRate = healthData
//         .where((element) => element.type == HealthDataType.HEART_RATE)
//         .toList();
//     heartRate.sort((a, b) => double.parse(a.value.toString())
//         .compareTo(double.parse(b.value.toString())));
//     // print(heartRate.last);
//     if (heartRate.isNotEmpty) {
//       list.add(heartRate.last);
//     }

//     return list;
//     // var permissions = [
//     //   HealthDataAccess.READ_WRITE,
//     //   HealthDataAccess.READ_WRITE
//     // ];
//     // await health.requestAuthorization(types, permissions: permissions);
//   }
// }
