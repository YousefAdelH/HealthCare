import 'package:dental_app/features/patient/model/class_session.dart';

class PatientModel {
  String? id;
  String? name;
  String? number;
  String? totalPrice;
  String? amountPaid;
  String? remainingAmount;

  String? gender; // New field for gender
  String? age;
  String? medicalhistory;
  List<Session>? session;
  Session? selectedSession;

  PatientModel({
    this.id,
    this.name,
    this.number,
    this.totalPrice,
    this.amountPaid,
    this.remainingAmount,
    // Initialize new field
    this.gender, // Initialize new field
    this.age, // Initialize new field
    this.medicalhistory, // Initialize new field
    this.session,
    this.selectedSession,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? "",
      'name': name ?? "",
      'number': number ?? "",
      'totalPrice': totalPrice ?? "0",
      'amountPaid': amountPaid ?? "0",
      'remainingAmount': remainingAmount ?? "0",
      'gender': gender,
      'age': age,
      'medicalhistory': medicalhistory,
      'session': session?.map((session) => session.toJson()).toList(),
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
        session: json['session'] != null
            ? (json['session'] as List<dynamic>)
                .map((item) => Session.fromJson(item))
                .toList()
            : []);
  }
  PatientModel copyWithSelectedSession(Session selectedSession) {
    return PatientModel(
      id: id,
      name: name,
      amountPaid: amountPaid,
      number: number,
      remainingAmount: remainingAmount,
      totalPrice: totalPrice,
      age: age,
      gender: gender,
      medicalhistory: medicalhistory,
      session: session,
      selectedSession: selectedSession,
    );
  }
}
