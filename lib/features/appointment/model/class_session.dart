class Session {
  final String? date;
  final String? note;
  final String? time;

  Session({
    required this.time,
    required this.date,
    required this.note,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      date: json['date'],
      note: json['note'],
      time: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'note': note,
      'time': note,
    };
  }
}
