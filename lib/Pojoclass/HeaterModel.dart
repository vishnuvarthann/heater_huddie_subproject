class HeaterModel {
  String connectionState;
  String connectionStateLastUpdatedTime;
  String controlStatus;
  String reason;
  int desiredHeaterState;
  String requestTime;
  int reportedHeaterState;
  String reportedTime;
  Detail detail;
  String snapshotTime;

  HeaterModel(
      {this.connectionState,
      this.connectionStateLastUpdatedTime,
      this.controlStatus,
      this.reason,
      this.desiredHeaterState,
      this.requestTime,
      this.reportedHeaterState,
      this.reportedTime,
      this.detail,
      this.snapshotTime});

  HeaterModel.fromJson(Map<String, dynamic> json) {
    connectionState = json['connectionState'];
    connectionStateLastUpdatedTime = json['connectionStateLastUpdatedTime'];
    controlStatus = json['controlStatus'];
    reason = json['reason'];
    desiredHeaterState = json['desiredHeaterState'];
    requestTime = json['requestTime'];
    reportedHeaterState = json['reportedHeaterState'];
    reportedTime = json['reportedTime'];
    detail =
        json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
    snapshotTime = json['snapshotTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connectionState'] = this.connectionState;
    data['connectionStateLastUpdatedTime'] =
        this.connectionStateLastUpdatedTime;
    data['controlStatus'] = this.controlStatus;
    data['reason'] = this.reason;
    data['desiredHeaterState'] = this.desiredHeaterState;
    data['requestTime'] = this.requestTime;
    data['reportedHeaterState'] = this.reportedHeaterState;
    data['reportedTime'] = this.reportedTime;
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    data['snapshotTime'] = this.snapshotTime;
    return data;
  }
}

class Detail {
  String executiveStatus;
  int actualHeaterState;
  String ignitionState;
  int supplyVoltage;
  String nextWakeUpTime;
  int heaterOnSeconds;
  int maxOnSeconds;
  int sleepCycleInSeconds;

  Detail(
      {this.executiveStatus,
      this.actualHeaterState,
      this.ignitionState,
      this.supplyVoltage,
      this.nextWakeUpTime,
      this.heaterOnSeconds,
      this.maxOnSeconds,
      this.sleepCycleInSeconds});

  Detail.fromJson(Map<String, dynamic> json) {
    executiveStatus = json['executiveStatus'];
    actualHeaterState = json['actualHeaterState'];
    ignitionState = json['ignitionState'];
    supplyVoltage = json['supplyVoltage'];
    nextWakeUpTime = json['nextWakeUpTime'];
    heaterOnSeconds = json['heaterOnSeconds'];
    maxOnSeconds = json['maxOnSeconds'];
    sleepCycleInSeconds = json['sleepCycleInSeconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['executiveStatus'] = this.executiveStatus;
    data['actualHeaterState'] = this.actualHeaterState;
    data['ignitionState'] = this.ignitionState;
    data['supplyVoltage'] = this.supplyVoltage;
    data['nextWakeUpTime'] = this.nextWakeUpTime;
    data['heaterOnSeconds'] = this.heaterOnSeconds;
    data['maxOnSeconds'] = this.maxOnSeconds;
    data['sleepCycleInSeconds'] = this.sleepCycleInSeconds;
    return data;
  }
}