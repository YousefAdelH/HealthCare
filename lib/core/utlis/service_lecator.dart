import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/core/utlis/cloudinary_service.dart';
import 'package:dental_app/features/appointment/repo/repository_appointment.dart';
import 'package:dental_app/features/badget_mangment/repo/Badget_repository.dart';
import 'package:dental_app/features/expences/repo/expense_repository.dart';
import 'package:dental_app/features/patient/repo/paient_repository.dart';
import 'package:dental_app/features/patient_image/repo/patient_image_repo.dart';
import 'package:dental_app/features/prescription/repo/prescription_reposatiry.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  getIt.registerLazySingleton<CloudinaryService>(() => CloudinaryService());

  // Register Expense dependencies
  getIt.registerLazySingleton<ExpenseRepository>(
      () => ExpenseRepository(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<AppointmentRepository>(
      () => AppointmentRepository(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<PrescriptionReposatiry>(() =>
      PrescriptionReposatiry(
          getIt<FirebaseFirestore>(), getIt<FirebaseStorage>()));
  getIt.registerLazySingleton<PatientRepository>(
      () => PatientRepository(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<BadgetRepository>(
      () => BadgetRepository(getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<ImageRepository>(() =>
      ImageRepository(getIt<FirebaseFirestore>(), getIt<CloudinaryService>()));
  //  getIt.registerLazySingleton<PatientDetailesRepository>(
  //     () => PatientDetailesRepository(getIt<FirebaseFirestore>()));
}
