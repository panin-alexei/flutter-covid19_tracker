import 'package:covid19_tracker/constants.dart';
import 'package:covid19_tracker/models/daily_snapshot.dart';
import 'package:covid19_tracker/screens/details/details_screen.dart';
import 'package:flutter/material.dart';

class DeathsCases extends AbstractDetailsScreen {
  List<DailySnapshot> snapshots;

  DeathsCases({this.snapshots}) : super(snapshots: snapshots);

  @override
  Color getColor() {
    return kDeathsColor;
  }

  @override
  List extractChartData(int amount) {
    return snapshots
        .sublist(snapshots.length - amount)
        .map((e) => e.deaths.toDouble())
        .toList();
  }

  @override
  double getAmount() {
    return this.snapshots.last.deaths.toDouble();
  }

  @override
  String getTitle() {
    return "Deaths";
  }

  @override
  double getFromLastWeekPercent() {
    if (this.snapshots.length < 7) {
      return 0;
    } else {
      return ((this.snapshots.last.deaths -
                  this.snapshots.elementAt(this.snapshots.length - 7).deaths) /
              this.snapshots.last.deaths) *
          100;
    }
  }

  @override
  double getFromYesterdayPercent() {
    if (this.snapshots.length < 2) {
      return 100;
    } else {
      return ((this.snapshots.last.deaths -
                  this.snapshots.elementAt(this.snapshots.length - 2).deaths) /
              this.snapshots.last.deaths) *
          100;
    }
  }
}
