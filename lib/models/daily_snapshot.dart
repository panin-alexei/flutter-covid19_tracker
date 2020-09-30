class DailySnapshot {
  final int active;
  final int confirmed;
  final int deaths;
  final int recovered;
  final DateTime date;
  int newCases = 0;
  int newDeaths = 0;

  DailySnapshot(
      {this.active, this.confirmed, this.deaths, this.recovered, this.date});

  factory DailySnapshot.fromJson(Map<String, dynamic> json) {
    return DailySnapshot(
        active: json['Active'],
        confirmed: json['Confirmed'],
        deaths: json['Deaths'],
        recovered: json['Recovered'],
        date: DateTime.parse(json['Date']));
  }
}
