import 'package:covid19_tracker/constants.dart';
import 'package:covid19_tracker/models/daily_snapshot.dart';
import 'package:covid19_tracker/screens/details/details_screen.dart';
import 'package:flutter/material.dart';

class NewDeaths extends AbstractDetailsScreen {
  List<DailySnapshot> snapshots;
  Color color;

  NewDeaths({this.snapshots}) : super(snapshots: snapshots);

  @override
  Color getColor() {
    return kNewDeathsColor;
  }

  @override
  List extractChartData(int amount) {
    return snapshots
        .sublist(snapshots.length - amount)
        .map((e) => e.newDeaths.toDouble())
        .toList();
  }

  @override
  double getAmount() {
    return this.snapshots.last.newDeaths.toDouble();
  }

  @override
  String getTitle() {
    return "Died today";
  }

  @override
  double getFromLastWeekPercent() {
    if (this.snapshots.length < 7) {
      return 0;
    } else {
      return ((this.snapshots.last.newDeaths -
                  this
                      .snapshots
                      .elementAt(this.snapshots.length - 7)
                      .newDeaths) /
              this.snapshots.last.newDeaths) *
          100;
    }
  }

  @override
  double getFromYesterdayPercent() {
    if (this.snapshots.length < 2) {
      return 100;
    } else {
      return ((this.snapshots.last.newDeaths -
                  this
                      .snapshots
                      .elementAt(this.snapshots.length - 2)
                      .newDeaths) /
              this.snapshots.last.newDeaths) *
          100;
    }
  }
}
