// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dental_app/features/appointment/model/patiant_model.dart';
// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final CollectionReference membersCollection =
//       FirebaseFirestore.instance.collection('patient');
//   final TextEditingController idController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController numberController = TextEditingController();
//   final TextEditingController totalpriceController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();

//   String remainingamount(String totalprice, String amount) {
//     double total = double.tryParse(totalprice) ?? 0.0;
//     double paid = double.tryParse(amount) ?? 0.0;
//     return (total - paid).toStringAsFixed(2);
//   }

//   void addMember() {
//     final docRef = membersCollection.doc();
//     final remainingAmount =
//         remainingamount(totalpriceController.text, amountController.text);
//     final member = PatientModel(
//       id: docRef.id,
//       name: nameController.text,
//       number: numberController.text,
//       totalPrice: totalpriceController.text,
//       amountPaid: amountController.text,
//       remainingAmount: remainingAmount ?? "",
//     );

//     docRef.set(member.toJson()).then((_) {
//       // Clear the text fields after adding the member
//       nameController.clear();
//       numberController.clear();
//       totalpriceController.clear();
//       amountController.clear();
//     });
//   }

//   void deleteMember(String memberId) {
//     membersCollection.doc(memberId).delete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('patient'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: numberController,
//               decoration: InputDecoration(labelText: 'Number'),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: totalpriceController,
//               decoration: InputDecoration(labelText: 'Total price'),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: amountController,
//               decoration: InputDecoration(labelText: 'Total amount paid'),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: addMember,
//             child: Text('Add Patient'),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(width: 1),
//             ),
//             width: MediaQuery.of(context).size.width / 2,
//             child: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       "name",
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       "number",
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       "totalPrice",
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       "amountPaid",
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       "remainingAmount",
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: membersCollection.snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Something went wrong'));
//                 }

//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Center(child: Text('No patients found'));
//                 }

//                 return SizedBox(
//                   width: MediaQuery.of(context).size.width / 2,
//                   child: ListView(
//                     children: snapshot.data!.docs.map((document) {
//                       if (document.data() == null) {
//                         return SizedBox.shrink(); // Empty widget for null data
//                       }
//                       final patientlist = PatientModel.fromJson(
//                           document.data()! as Map<String, dynamic>);
//                       return PatientView(
//                         name: patientlist.name,
//                         number: patientlist.number,
//                         totalPrice: patientlist.totalPrice,
//                         amountPaid: patientlist.amountPaid,
//                         remainingAmount: patientlist.remainingAmount,
//                         onDelete: () => deleteMember(document.id),
//                       );
//                     }).toList(),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PatientView extends StatelessWidget {
//   final String? name;
//   final String? number;
//   final String? totalPrice;
//   final String? amountPaid;
//   final String? remainingAmount;
//   final VoidCallback onDelete;

//   const PatientView({
//     Key? key,
//     required this.name,
//     required this.number,
//     required this.onDelete,
//     required this.totalPrice,
//     required this.amountPaid,
//     required this.remainingAmount,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Text(
//               name ?? "",
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               number ?? "",
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               totalPrice ?? "",
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               amountPaid ?? "",
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               remainingAmount ?? "",
//               textAlign: TextAlign.center,
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.delete),
//             onPressed: onDelete,
//           ),
//         ],
//       ),
//     );
//   }
// }
