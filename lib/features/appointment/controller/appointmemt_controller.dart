import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/core/error/error_handle.dart';
import 'package:dental_app/core/error/model/custom_exceptions.dart';
import 'package:dental_app/features/appointment/repo/repository_appointment.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class AppointmemtCtrl extends GetxController {
  final AppointmentRepository _repository = GetIt.I<AppointmentRepository>();

  var sessionsOnDate = <PatientModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedDate = DateTime.now().obs;

  // Future<void> searchSessionsOnDate(DateTime date) async {
  //   try {
  //     isLoading.value = true;
  //     List<PatientModel> sessions = [];
  //     String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  //     print(formattedDate); // Format the date

  //     QuerySnapshot patientsSnapshot =
  //         await _firestore.collection('patient').get();
  //     for (var doc in patientsSnapshot.docs) {
  //       var data = doc.data() as Map<String, dynamic>;
  //       var patient = PatientModel.fromJson(data);

  //       if (patient.session != null)
  //         for (var session in patient.session!) {
  //           if (session.date == formattedDate) {
  //             sessions.add(
  //               patient.copyWithSelectedSession(session),
  //             );
  //           }
  //         }
  //     }

  //     sessionsOnDate.value = sessions;
  //   } catch (e) {
  //     errorMessage.value = e.toString();
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  Future<void> searchSessionsOnDate(DateTime date) async {
    isLoading.value = true;

    try {
      sessionsOnDate.value = await _repository.getSessionsOnDate(date);
    } on DatabaseException catch (e) {
      ErrorHandler.logError(e.message);
      ErrorHandler.showError("Error: ${e.message}");
    } catch (e) {
      ErrorHandler.logError('Unknown error occurred', e);
      ErrorHandler.showError("Unknown error occurred");
    } finally {
      isLoading.value = false; // Ensure loading indicator stops
    }
    // isLoading.value = false;
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    searchSessionsOnDate(date);
  }
}
