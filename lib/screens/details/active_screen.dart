import 'package:covid19_tracker/constants.dart';
import 'package:covid19_tracker/models/daily_snapshot.dart';
import 'package:covid19_tracker/screens/details/details_screen.dart';
import 'package:flutter/material.dart';

class ActiveCases extends AbstractDetailsScreen {
  List<DailySnapshot> snapshots;

  ActiveCases({this.snapshots}) : super(snapshots: snapshots);

  @override
  Color getColor() {
    return kActiveColor;
  }

  @override
  List extractChartData(int amount) {
    return snapshots
        .sublist(snapshots.length - amount)
        .map((e) => e.active.toDouble())
        .toList();
  }

  @override
  double getAmount() {
    return this.snapshots.last.active.toDouble();
  }

  @override
  String getTitle() {
    return "Active cases";
  }

  @override
  double getFromLastWeekPercent() {
    if (this.snapshots.length < 7) {
      return 0;
    } else {
      return ((this.snapshots.last.active -
                  this.snapshots.elementAt(this.snapshots.length - 7).active) /
              this.snapshots.last.active) *
          100;
    }
  }

  @override
  double getFromYesterdayPercent() {
    if (this.snapshots.length < 2) {
      return 100;
    } else {
      return ((this.snapshots.last.active -
                  this.snapshots.elementAt(this.snapshots.length - 2).active) /
              this.snapshots.last.active) *
          100;
    }
  }
}
