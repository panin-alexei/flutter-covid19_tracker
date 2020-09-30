import 'package:covid19_tracker/constants.dart';
import 'package:covid19_tracker/models/daily_snapshot.dart';
import 'package:covid19_tracker/widgets/b_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

abstract class AbstractDetailsScreen extends StatelessWidget {
  String getTitle();
  double getAmount();
  List extractChartData(int amount);
  double getFromYesterdayPercent();
  double getFromLastWeekPercent();
  Color getColor();
  double getRecoveryRate() {
    return (this.snapshots.last.recovered / this.snapshots.last.confirmed) *
        100;
  }

  List extractChartLabels(int amount) {
    return snapshots
        .sublist(snapshots.length - amount)
        .map((e) => DateFormat("E").format(e.date))
        .toList();
  }

  List<DailySnapshot> snapshots;

  AbstractDetailsScreen({this.snapshots});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildTitle(),
                    SizedBox(height: 15),
                    buildCaseNumber(context),
                    SizedBox(height: 15),
                    Text(
                      "Data from World Health Organization",
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: kTextMediumColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 15),
                    BChart(
                      color: getColor(),
                      barData: extractChartData(7),
                      barLabels: extractChartLabels(7),
                    ),
                    SizedBox(height: 55),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        buildInfoTextWithPercentage(
                          percentage:
                              getFromLastWeekPercent().toStringAsFixed(2),
                          title: "From Last Week",
                        ),
                        buildInfoTextWithPercentage(
                          percentage: getRecoveryRate().toStringAsFixed(2),
                          title: "Recovery Rate",
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: kPrimaryColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  RichText buildInfoTextWithPercentage({String title, String percentage}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$percentage% \n",
            style: TextStyle(
              fontSize: 20,
              color: kPrimaryColor,
            ),
          ),
          TextSpan(
            text: title,
            style: TextStyle(
              color: kTextMediumColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Row buildCaseNumber(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          getAmount().toInt().toString(),
          style: Theme.of(context)
              .textTheme
              .headline2
              .copyWith(color: kPrimaryColor, height: 1.2),
        ),
        Spacer(),
        Text(
          getFromYesterdayPercent().toStringAsFixed(2) + "% ",
          style: TextStyle(color: kPrimaryColor),
        ),
      ],
    );
  }

  Row buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          getTitle(),
          style: TextStyle(
            color: kTextMediumColor,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
