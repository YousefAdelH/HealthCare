import 'package:cloud_firestore/cloud_firestore.dart';

class DentalMaterial {
  String id;
  String name;
  int quantity;
  String expirationDate;
  double wholesalePrice;
  double sellingPrice;

  DentalMaterial({
    required this.id,
    required this.name,
    required this.quantity,
    required this.expirationDate,
    required this.wholesalePrice,
    required this.sellingPrice,
  });

  double get gainPrice => sellingPrice - wholesalePrice;

  factory DentalMaterial.fromMap(Map<String, dynamic> data, String documentId) {
    return DentalMaterial(
      id: documentId,
      name: data['name'],
      quantity: data['quantity'],
      expirationDate: data['expirationDate'],
      wholesalePrice: data['wholesalePrice'],
      sellingPrice: data['sellingPrice'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'expirationDate': expirationDate,
      'wholesalePrice': wholesalePrice,
      'sellingPrice': sellingPrice,
    };
  }
}
