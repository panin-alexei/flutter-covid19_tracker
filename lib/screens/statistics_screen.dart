import 'package:covid19_tracker/constants.dart';
import 'package:covid19_tracker/models/daily_snapshot.dart';
import 'package:covid19_tracker/screens/details/active_screen.dart';
import 'package:covid19_tracker/screens/details/confirmed_screen.dart';
import 'package:covid19_tracker/screens/details/deaths_screen.dart';
import 'package:covid19_tracker/screens/details/new_cases_screen.dart';
import 'package:covid19_tracker/screens/details/new_deaths_screen.dart';
import 'package:covid19_tracker/screens/details/recovered_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid19_tracker/widgets/stat_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StatisticsScreen extends StatefulWidget {
  StatisticsScreen({Key key}) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

Future<List<DailySnapshot>> fetchDailySnapshots() async {
  final response = await http.get('https://api.covid19api.com/country/moldova');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON
    List<DailySnapshot> result = [];

    var jsonObjectsList = json.decode(response.body) as List;

    jsonObjectsList.forEach(
        (dailySnapshot) => result.add(DailySnapshot.fromJson(dailySnapshot)));

    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  Future<List<DailySnapshot>> futureDailySnapshots;
  List<DailySnapshot> rawSnapshots = [];

  @override
  void initState() {
    super.initState();
    futureDailySnapshots = fetchDailySnapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/covid_bkg.png"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // will not use navbar
          // scroll-view is used for smaller screen-sizes
          body: SingleChildScrollView(
            child: FutureBuilder<List<DailySnapshot>>(
              future: futureDailySnapshots,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = aggregateSnapshots(snapshot.data);
                  this.rawSnapshots = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildCardsBlock(context, data),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
          ),
        ));
  }

  List<DailySnapshot> aggregateSnapshots(List<DailySnapshot> snashotList) {
    for (var i = 0; i < snashotList.length; i++) {
      if (i == 0) {
        snashotList.elementAt(i).newCases = snashotList.elementAt(i).confirmed;
        snashotList.elementAt(i).newDeaths = snashotList.elementAt(i).deaths;
      } else {
        snashotList.elementAt(i).newCases = snashotList.elementAt(i).confirmed -
            snashotList.elementAt(i - 1).confirmed;
        snashotList.elementAt(i).newDeaths = snashotList.elementAt(i).deaths -
            snashotList.elementAt(i - 1).deaths;
      }
    }

    return snashotList;
  }

  Container buildCardsBlock(
      BuildContext context, List<DailySnapshot> snapshots) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Wrap(runSpacing: 20, spacing: 20, children: <Widget>[
        StatCard(
          title: "New cases",
          iconColor: kNewCasesColor,
          affectedNumber: snapshots.last.newCases,
          chartData: snapshots
              .map((element) => element.newCases.toDouble())
              .toList()
              .sublist(snapshots.length - 7),
          onPress: () {
            this.onPressAction(NewCases(snapshots: this.rawSnapshots));
          },
          icon: Icons.airline_seat_flat_angled,
        ),
        StatCard(
          title: "New deaths",
          iconColor: kNewDeathsColor,
          affectedNumber: snapshots.last.newDeaths,
          chartData: snapshots
              .map((element) => element.newDeaths.toDouble())
              .toList()
              .sublist(snapshots.length - 7),
          onPress: () {
            this.onPressAction(NewDeaths(snapshots: this.rawSnapshots));
          },
          icon: Icons.power_settings_new,
        ),
        StatCard(
          title: "Confirmed",
          iconColor: kConfirmedColor,
          affectedNumber: snapshots.last.confirmed,
          chartData: snapshots
              .map((element) => element.confirmed.toDouble())
              .toList()
              .sublist(snapshots.length - 7),
          onPress: () {
            this.onPressAction(ConfirmedCases(snapshots: this.rawSnapshots));
          },
          icon: Icons.airline_seat_flat_angled,
        ),
        StatCard(
          title: "Deaths",
          iconColor: kDeathsColor,
          affectedNumber: snapshots.last.deaths,
          chartData: snapshots
              .map((element) => element.deaths.toDouble())
              .toList()
              .sublist(snapshots.length - 7),
          onPress: () {
            this.onPressAction(DeathsCases(snapshots: this.rawSnapshots));
          },
          icon: Icons.power_settings_new,
        ),
        StatCard(
          title: "Active",
          iconColor: kActiveColor,
          affectedNumber: snapshots.last.active,
          chartData: snapshots
              .map((element) => element.active.toDouble())
              .toList()
              .sublist(snapshots.length - 7),
          onPress: () {
            this.onPressAction(ActiveCases(snapshots: this.rawSnapshots));
          },
          icon: Icons.airline_seat_flat_angled,
        ),
        StatCard(
          title: "Recovered",
          iconColor: kRecoveredColor,
          affectedNumber: snapshots.last.recovered,
          chartData: snapshots
              .map((element) => element.recovered.toDouble())
              .toList()
              .sublist(snapshots.length - 7),
          onPress: () {
            this.onPressAction(RecoveredCases(snapshots: this.rawSnapshots));
          },
          icon: Icons.directions_run,
        ),
      ]),
    );
  }

  onPressAction(detailsView) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return detailsView;
        },
      ),
    );
  }
}
