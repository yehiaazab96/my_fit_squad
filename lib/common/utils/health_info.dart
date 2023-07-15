import 'package:health/health.dart';

class HealthInfo {
  static getHeatldataforDuartion(
      {Duration? duartion, List<HealthDataType>? dataTypes}) async {
    HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

    var types = dataTypes ?? [];

    bool requested = await health.requestAuthorization(types);

    var now = DateTime.now();

    List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        now.subtract(duartion ?? Duration.zero), now, types);

    // var permissions = [
    //   HealthDataAccess.READ_WRITE,
    //   HealthDataAccess.READ_WRITE
    // ];
    // await health.requestAuthorization(types, permissions: permissions);
  }
}
