class Session {
  String? id;
  String? date;
  String? note;
  String? time;
  String? price;
  String? operations;

  Session(
      {this.time, this.date, this.note, this.price, this.id, this.operations});

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
        id: json['id'] ?? "",
        date: json['date'] ?? "",
        note: json['note'] ?? "",
        time: json['time'] ?? "",
        price: json['price'] ?? "",
        operations: json['operations'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'note': note,
      'time': time,
      'price': price,
      'id': id,
      'operations': operations
    };
  }
}
