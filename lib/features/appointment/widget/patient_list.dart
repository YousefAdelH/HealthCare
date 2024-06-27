import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/features/appointment/widget/patient_card.dart';
import 'package:dental_app/patiant_model.dart';
import 'package:flutter/material.dart';

// class DisplayAllpatient extends StatelessWidget {
//   const DisplayAllpatient({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('patient').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Something went wrong'));
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No patients found'));
//           }
//           List<PatientModel> patients = snapshot.data!.docs.map((doc) {
//             Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//             return PatientModel.fromJson(data);
//           }).toList();
//           return Expanded(
//             child: ListView.builder(
//               scrollDirection: Axis.vertical,
//               padding: EdgeInsets.zero,
//               itemCount: patients.length,
//               itemBuilder: (context, index) {
//                 return PatientCard(
//                   item: patients[index],
//                 );
//               },
//             ),
//           );
//         });
//   }
// }

class DisplayAllpatient extends StatefulWidget {
  const DisplayAllpatient({super.key});

  @override
  _DisplayAllpatientState createState() => _DisplayAllpatientState();
}

class _DisplayAllpatientState extends State<DisplayAllpatient> {
  final int _limit = 5;
  DocumentSnapshot? _lastDocument;
  List<PatientModel> _patients = [];
  bool _isLoading = false;
  bool _hasMore = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchPatients();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchPatients();
      }
    });
  }

  Future<void> _fetchPatients() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    Query query = FirebaseFirestore.instance
        .collection('patient')
        .orderBy('name')
        .limit(_limit);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    final QuerySnapshot querySnapshot = await query.get();

    if (querySnapshot.docs.length < _limit) {
      _hasMore = false;
    }

    if (querySnapshot.docs.isNotEmpty) {
      _lastDocument = querySnapshot.docs.last;

      List<PatientModel> newPatients = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return PatientModel.fromJson(data);
      }).toList();

      setState(() {
        _patients.addAll(newPatients);
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemCount: _patients.length + 1,
          itemBuilder: (context, index) {
            if (index == _patients.length) {
              return _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _hasMore
                      ? SizedBox.shrink()
                      : Center(child: Text('No more patients'));
            }

            return PatientCard(item: _patients[index]);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
