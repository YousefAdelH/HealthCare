import 'package:dental_app/features/appointment/model/class_session.dart';

class PatientModel {
  String id;
  String? name;
  String? number;
  String? totalPrice;
  String? amountPaid;
  String? remainingAmount;

  String? gender; // New field for gender
  String? age;
  String? medicalhistory;
  final List<Session>? sessions;

  PatientModel({
    required this.id,
    required this.name,
    required this.number,
    required this.totalPrice,
    required this.amountPaid,
    required this.remainingAmount,
    // Initialize new field
    this.gender, // Initialize new field
    this.age, // Initialize new field
    this.medicalhistory, // Initialize new field
    this.sessions,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'totalPrice': totalPrice ?? "0",
      'amountPaid': amountPaid ?? "0",
      'remainingAmount': remainingAmount ?? "0",
      'gender': gender,
      'age': age,
      'medicalhistory': medicalhistory,
      'sessions': sessions?.map((session) => session.toJson()).toList(),
    };
  }

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    // var sessionsFromJson = json['sessions'] != null ? json['sessions'] : [];

    //     sessionsFromJson.map((i) => Session.fromJson(i)).toList() as ;
    return PatientModel(
        id: json['id'] ?? "",
        name: json['name'] ?? "",
        number: json['number'] ?? "",
        totalPrice: json['totalPrice'] ?? "",
        amountPaid: json['amountPaid'] ?? "",
        remainingAmount: json['remainingAmount'] ?? "",
        gender: json['gender'] ?? "", // Parse new field
        age: json['age'] ?? "", // Parse new field
        medicalhistory: json['medicalhistory'] ?? "", // Parse new field
        sessions: json['sessions'] != null
            ? (json['sessions'] as List<dynamic>?)
                ?.map((item) => Session.fromJson(item as Map<String, dynamic>))
                .toList()
            : []);
  }
}
