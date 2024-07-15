import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/features/patient/model/class_session.dart';
import 'package:get/get.dart';

class PatientModel {
  String? id;
  String? name;
  String? number;
  String? code;
  String? totalPrice;
  String? amountPaid;
  String? remainingAmount;
  String? gender; // New field for gender
  String? age;
  String? medicalhistory;
  List<Session>? session;
  Session? selectedSession;
  List<String>? images;

  PatientModel({
    this.id,
    this.name,
    this.number,
    this.code,
    this.totalPrice,
    this.amountPaid,
    this.remainingAmount,
    this.gender, // Initialize new field
    this.age, // Initialize new field
    this.medicalhistory, // Initialize new field
    this.session,
    this.selectedSession,
    this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? "",
      'name': name ?? "",
      'number': number ?? "",
      'code': code ?? "",
      'totalPrice': totalPrice ?? "0",
      'amountPaid': amountPaid ?? "0",
      'remainingAmount': remainingAmount ?? "0",
      'gender': gender,
      'age': age,
      'medicalhistory': medicalhistory,
      'session': session?.map((session) => session.toJson()).toList(),
      'images': images ?? [],
    };
  }

  double calculateTotalPriceWithinDateRange(
      DateTime startDate, DateTime endDate) {
    if (session == null) return 0.0;

    double total = 0.0;
    DateTime adjustedStartDate =
        DateTime(startDate.year, startDate.month, startDate.day);
    DateTime adjustedEndDate =
        DateTime(endDate.year, endDate.month, endDate.day)
            .add(Duration(days: 1));

    for (var s in session!) {
      DateTime? sessionDate = DateTime.tryParse(s.date ?? "");
      if (sessionDate != null) {
        DateTime adjustedSessionDate =
            DateTime(sessionDate.year, sessionDate.month, sessionDate.day);
        if (adjustedSessionDate.isAfter(adjustedStartDate) &&
            adjustedSessionDate.isBefore(adjustedEndDate)) {
          double sessionPrice = double.tryParse(s.price ?? "0.0") ?? 0.0;
          total += sessionPrice;
          print("////////////////////////////////total");
          print(total);
        }
      }
    }
    return total;
  }

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    // var sessionsFromJson = json['sessions'] != null ? json['sessions'] : [];

    //     sessionsFromJson.map((i) => Session.fromJson(i)).toList() as ;
    return PatientModel(
        id: json['id'] ?? "",
        name: json['name'] ?? "",
        code: json['code'] ?? "",
        number: json['number'] ?? "",
        totalPrice: json['totalPrice'] ?? "",
        amountPaid: json['amountPaid'] ?? "",
        remainingAmount: json['remainingAmount'] ?? "",
        gender: json['gender'] ?? "", // Parse new field
        age: json['age'] ?? "", // Parse new field
        medicalhistory: json['medicalhistory'] ?? "",
        images: json['images'] != null
            ? List<String>.from(json['images'])
            : [], // Parse new field // Parse new field
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
      code: code,
      amountPaid: amountPaid,
      number: number,
      remainingAmount: remainingAmount,
      totalPrice: totalPrice,
      age: age,
      gender: gender,
      medicalhistory: medicalhistory,
      session: session,
      selectedSession: selectedSession,
      images: images,
    );
  }
}
