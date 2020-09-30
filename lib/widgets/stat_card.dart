import 'package:covid19_tracker/constants.dart';
import 'package:covid19_tracker/widgets/l_chart.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final int affectedNumber;
  final IconData icon;
  final Color iconColor;
  final Function onPress;
  final List chartData;
  const StatCard(
      {Key key,
      this.title,
      this.icon,
      this.affectedNumber,
      this.iconColor,
      this.onPress,
      this.chartData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: onPress,
          child: Container(
            width: constraints.maxWidth / 2 - 10,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildTitleRow(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: buildChart(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: buildAffectedRow(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildChart() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: LChart(
        data: chartData,
      ),
    );
  }

  Row buildAffectedRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.white70),
              children: [
                TextSpan(
                  text: "$affectedNumber \n",
                  style: TextStyle(
                    fontSize: 40,
                    height: 1,
                  ),
                ),
                TextSpan(
                  text: "People",
                  style: TextStyle(
                    fontSize: 16,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row buildTitleRow() {
    return Row(
      children: <Widget>[
        // for small density device
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20.0,
            ),
          ),
        ),
        Spacer(),
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 16, height: 1, color: Colors.white),
        )
      ],
    );
  }
}
