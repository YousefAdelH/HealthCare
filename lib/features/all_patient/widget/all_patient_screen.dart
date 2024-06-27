import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllPatient extends StatefulWidget {
  @override
  _SearchSessionsState createState() => _SearchSessionsState();
}

class _SearchSessionsState extends State<AllPatient> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> searchSessionsOnDate(String date) async {
    List<Map<String, dynamic>> sessionsOnDate = [];

    QuerySnapshot patientsSnapshot =
        await _firestore.collection('patient').get();
    for (var doc in patientsSnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      if (data['session'] != null) {
        List sessions = data['session'];
        for (var session in sessions) {
          if (session['date'] == date) {
            sessionsOnDate.add({
              'patientId': doc.id,
              'patientName': data['name'],
              'session': session,
            });
          }
        }
      }
    }

    return sessionsOnDate;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: searchSessionsOnDate("2024-07-21"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Text('No sessions found on the specified date.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var sessionData = snapshot.data![index];
              return ListTile(
                title: Text('Patient: ${sessionData['patientName']}'),
                subtitle: Text(
                    'Date: ${sessionData['session']['date']}, Note: ${sessionData['session']['note']}'),
              );
            },
          );
        }
      },
    );
  }
}
