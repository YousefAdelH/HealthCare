class PatientModel {
  String id;
  String? name;
  String? number;
  String? totalPrice;
  String? amountPaid;
  String? remainingAmount;
  String? date; // New field for date
  String? time; // New field for time
  String? gender; // New field for gender
  String? age;
  String? medicalhistory;

  PatientModel({
    required this.id,
    required this.name,
    required this.number,
    required this.totalPrice,
    required this.amountPaid,
    required this.remainingAmount,
    this.date, // Initialize new field
    this.time, // Initialize new field
    this.gender, // Initialize new field
    this.age, // Initialize new field
    this.medicalhistory, // Initialize new field
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'totalPrice': totalPrice,
      'amountPaid': amountPaid,
      'remainingAmount': remainingAmount,
      'date': date,
      'time': time,
      'gender': gender,
      'age': age,
      'medicalhistory': medicalhistory,
    };
  }

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      number: json['number'] ?? "",
      totalPrice: json['totalPrice'] ?? "",
      amountPaid: json['amountPaid'] ?? "",
      remainingAmount: json['remainingAmount'] ?? "",
      date: json['date'] ?? "", // Parse new field
      time: json['time'] ?? "", // Parse new field
      gender: json['gender'] ?? "", // Parse new field
      age: json['age'] ?? "", // Parse new field
      medicalhistory: json['medicalhistory'] ?? "", // Parse new field
    );
  }
}
