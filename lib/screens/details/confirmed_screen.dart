import 'package:covid19_tracker/constants.dart';
import 'package:covid19_tracker/models/daily_snapshot.dart';
import 'package:covid19_tracker/screens/details/details_screen.dart';
import 'package:flutter/material.dart';

class ConfirmedCases extends AbstractDetailsScreen {
  List<DailySnapshot> snapshots;

  ConfirmedCases({this.snapshots}) : super(snapshots: snapshots);

  @override
  Color getColor() {
    return kConfirmedColor;
  }

  @override
  List extractChartData(int amount) {
    return snapshots
        .sublist(snapshots.length - amount)
        .map((e) => e.confirmed.toDouble())
        .toList();
  }

  @override
  double getAmount() {
    return this.snapshots.last.confirmed.toDouble();
  }

  @override
  String getTitle() {
    return "Confirmed since ...";
  }

  @override
  double getFromLastWeekPercent() {
    if (this.snapshots.length < 7) {
      return 0;
    } else {
      return ((this.snapshots.last.confirmed -
                  this
                      .snapshots
                      .elementAt(this.snapshots.length - 7)
                      .confirmed) /
              this.snapshots.last.confirmed) *
          100;
    }
  }

  @override
  double getFromYesterdayPercent() {
    if (this.snapshots.length < 2) {
      return 100;
    } else {
      return ((this.snapshots.last.confirmed -
                  this
                      .snapshots
                      .elementAt(this.snapshots.length - 2)
                      .confirmed) /
              this.snapshots.last.confirmed) *
          100;
    }
  }
}
