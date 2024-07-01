class Session {
  String? id;
  String? date;
  String? note;
  String? time;
  String? price;

  Session({this.time, this.date, this.note, this.price, this.id});

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
        id: json['id'] ?? "",
        date: json['date'] ?? "",
        note: json['note'] ?? "",
        time: json['time'] ?? "",
        price: json['price'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {'date': date, 'note': note, 'time': time, 'price': price, 'id': id};
  }
}
