import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmemtCtrl extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var sessionsOnDate = <PatientModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedDate = DateTime.now().obs;

  Future<void> searchSessionsOnDate(DateTime date) async {
    try {
      isLoading.value = true;
      List<PatientModel> sessions = [];
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      print(formattedDate); // Format the date

      QuerySnapshot patientsSnapshot =
          await _firestore.collection('patient').get();
      for (var doc in patientsSnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        var patient = PatientModel.fromJson(data);
        if (patient.session != null)
          for (var session in patient.session!) {
            if (session.date == formattedDate) {
              sessions.add(
                patient.copyWithSelectedSession(session),
              );
            }
          }
      }

      sessionsOnDate.value = sessions;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    searchSessionsOnDate(date);
  }
}
