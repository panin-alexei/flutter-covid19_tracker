import 'package:covid19_tracker/constants.dart';
import 'package:covid19_tracker/models/daily_snapshot.dart';
import 'package:covid19_tracker/screens/details/details_screen.dart';
import 'package:flutter/material.dart';

class RecoveredCases extends AbstractDetailsScreen {
  List<DailySnapshot> snapshots;

  RecoveredCases({this.snapshots}) : super(snapshots: snapshots);

  @override
  Color getColor() {
    return kRecoveredColor;
  }

  @override
  List extractChartData(int amount) {
    return snapshots
        .sublist(snapshots.length - amount)
        .map((e) => e.recovered.toDouble())
        .toList();
  }

  @override
  double getAmount() {
    return this.snapshots.last.recovered.toDouble();
  }

  @override
  String getTitle() {
    return "Recovered cases";
  }

  @override
  double getFromLastWeekPercent() {
    if (this.snapshots.length < 7) {
      return 0;
    } else {
      return ((this.snapshots.last.recovered -
                  this
                      .snapshots
                      .elementAt(this.snapshots.length - 7)
                      .recovered) /
              this.snapshots.last.recovered) *
          100;
    }
  }

  @override
  double getFromYesterdayPercent() {
    if (this.snapshots.length < 2) {
      return 100;
    } else {
      return ((this.snapshots.last.recovered -
                  this
                      .snapshots
                      .elementAt(this.snapshots.length - 2)
                      .recovered) /
              this.snapshots.last.recovered) *
          100;
    }
  }
}
