import 'package:covid19_tracker/constants.dart';
import 'package:covid19_tracker/models/daily_snapshot.dart';
import 'package:covid19_tracker/screens/details/details_screen.dart';
import 'package:flutter/material.dart';

class NewCases extends AbstractDetailsScreen {
  List<DailySnapshot> snapshots;

  NewCases({this.snapshots}) : super(snapshots: snapshots);

  @override
  Color getColor() {
    return kNewCasesColor;
  }

  @override
  List extractChartData(int amount) {
    return snapshots
        .sublist(snapshots.length - amount)
        .map((e) => e.newCases.toDouble())
        .toList();
  }

  @override
  double getAmount() {
    return this.snapshots.last.newCases.toDouble();
  }

  @override
  String getTitle() {
    return "Discovered today";
  }

  @override
  double getFromLastWeekPercent() {
    if (this.snapshots.length < 7) {
      return 0;
    } else {
      return ((this.snapshots.last.newCases -
                  this
                      .snapshots
                      .elementAt(this.snapshots.length - 7)
                      .newCases) /
              this.snapshots.last.newCases) *
          100;
    }
  }

  @override
  double getFromYesterdayPercent() {
    if (this.snapshots.length < 2) {
      return 100;
    } else {
      return ((this.snapshots.last.newCases -
                  this
                      .snapshots
                      .elementAt(this.snapshots.length - 2)
                      .newCases) /
              this.snapshots.last.newCases) *
          100;
    }
  }
}
