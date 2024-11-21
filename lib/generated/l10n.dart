// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get sidebar_home {
    return Intl.message(
      'Home',
      name: 'sidebar_home',
      desc: '',
      args: [],
    );
  }

  /// `Appointment`
  String get sidebar_appointment {
    return Intl.message(
      'Appointment',
      name: 'sidebar_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Patients`
  String get sidebar_patients {
    return Intl.message(
      'Patients',
      name: 'sidebar_patients',
      desc: '',
      args: [],
    );
  }

  /// `Medications`
  String get sidebar_medications {
    return Intl.message(
      'Medications',
      name: 'sidebar_medications',
      desc: '',
      args: [],
    );
  }

  /// `Expenses`
  String get sidebar_expenses {
    return Intl.message(
      'Expenses',
      name: 'sidebar_expenses',
      desc: '',
      args: [],
    );
  }

  /// `Budget management`
  String get sidebar_budget_management {
    return Intl.message(
      'Budget management',
      name: 'sidebar_budget_management',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get sidebar_logout {
    return Intl.message(
      'Logout',
      name: 'sidebar_logout',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get title {
    return Intl.message(
      'Home',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get number {
    return Intl.message(
      'Number',
      name: 'number',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signup {
    return Intl.message(
      'Sign up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter password',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email`
  String get pleaseEnterEmail {
    return Intl.message(
      'Please enter email',
      name: 'pleaseEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Patient`
  String get patient {
    return Intl.message(
      'Patient',
      name: 'patient',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Medical history`
  String get medicalHistory {
    return Intl.message(
      'Medical history',
      name: 'medicalHistory',
      desc: '',
      args: [],
    );
  }

  /// `Session Note`
  String get sessionNote {
    return Intl.message(
      'Session Note',
      name: 'sessionNote',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get totalAmount {
    return Intl.message(
      'Total Amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Amount Paid`
  String get amountPaid {
    return Intl.message(
      'Amount Paid',
      name: 'amountPaid',
      desc: '',
      args: [],
    );
  }

  /// `Remaining Amount`
  String get remainingAmount {
    return Intl.message(
      'Remaining Amount',
      name: 'remainingAmount',
      desc: '',
      args: [],
    );
  }

  /// `Select Gender`
  String get selectGender {
    return Intl.message(
      'Select Gender',
      name: 'selectGender',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message(
      'Select Date',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `Select Time`
  String get selectTime {
    return Intl.message(
      'Select Time',
      name: 'selectTime',
      desc: '',
      args: [],
    );
  }

  /// `Add Patient`
  String get addPatient {
    return Intl.message(
      'Add Patient',
      name: 'addPatient',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `appointment`
  String get appointment {
    return Intl.message(
      'appointment',
      name: 'appointment',
      desc: '',
      args: [],
    );
  }

  /// `patients`
  String get patients {
    return Intl.message(
      'patients',
      name: 'patients',
      desc: '',
      args: [],
    );
  }

  /// `equipment`
  String get equipment {
    return Intl.message(
      'equipment',
      name: 'equipment',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `logout`
  String get logout {
    return Intl.message(
      'logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Not found page`
  String get notFoundPage {
    return Intl.message(
      'Not found page',
      name: 'notFoundPage',
      desc: '',
      args: [],
    );
  }

  /// `pleaseEnteremail`
  String get pleaseEnteremail {
    return Intl.message(
      'pleaseEnteremail',
      name: 'pleaseEnteremail',
      desc: '',
      args: [],
    );
  }

  /// `pleaseEnterpassword`
  String get pleaseEnterpassword {
    return Intl.message(
      'pleaseEnterpassword',
      name: 'pleaseEnterpassword',
      desc: '',
      args: [],
    );
  }

  /// `No more patients`
  String get noMorePatients {
    return Intl.message(
      'No more patients',
      name: 'noMorePatients',
      desc: '',
      args: [],
    );
  }

  /// `No session`
  String get noSession {
    return Intl.message(
      'No session',
      name: 'noSession',
      desc: '',
      args: [],
    );
  }

  /// `New Patient`
  String get newPatient {
    return Intl.message(
      'New Patient',
      name: 'newPatient',
      desc: '',
      args: [],
    );
  }

  /// `New patient added successfully.`
  String get newPatientAddedSuccessfully {
    return Intl.message(
      'New patient added successfully.',
      name: 'newPatientAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Patient deleted successfully`
  String get patientDeletedSuccessfully {
    return Intl.message(
      'Patient deleted successfully',
      name: 'patientDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Patient deleted successfully`
  String get sessionDeletedSuccessfully {
    return Intl.message(
      'Patient deleted successfully',
      name: 'sessionDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete patient`
  String get failedToDeletePatient {
    return Intl.message(
      'Failed to delete patient',
      name: 'failedToDeletePatient',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to permanently delete this patient's data?`
  String get deletePatientConfirmation {
    return Intl.message(
      'Are you sure to permanently delete this patient\'s data?',
      name: 'deletePatientConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Delete Patient`
  String get deletePatient {
    return Intl.message(
      'Delete Patient',
      name: 'deletePatient',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Patient Details`
  String get patientDetails {
    return Intl.message(
      'Patient Details',
      name: 'patientDetails',
      desc: '',
      args: [],
    );
  }

  /// `Add New Session`
  String get addNewSession {
    return Intl.message(
      'Add New Session',
      name: 'addNewSession',
      desc: '',
      args: [],
    );
  }

  /// `New Session added successfully.`
  String get newSessionAddedSuccessfully {
    return Intl.message(
      'New Session added successfully.',
      name: 'newSessionAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `New Session`
  String get newSession {
    return Intl.message(
      'New Session',
      name: 'newSession',
      desc: '',
      args: [],
    );
  }

  /// `No sessions available`
  String get noSessionsAvailable {
    return Intl.message(
      'No sessions available',
      name: 'noSessionsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `save`
  String get save {
    return Intl.message(
      'save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Patient not found`
  String get patientNotFound {
    return Intl.message(
      'Patient not found',
      name: 'patientNotFound',
      desc: '',
      args: [],
    );
  }

  /// `patient successfully updated!`
  String get patientSuccessfullyUpdated {
    return Intl.message(
      'patient successfully updated!',
      name: 'patientSuccessfullyUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Error updating patient`
  String get errorUpdatingPatient {
    return Intl.message(
      'Error updating patient',
      name: 'errorUpdatingPatient',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to permanently delete this session?`
  String get deleteSessionConfirmation {
    return Intl.message(
      'Are you sure you want to permanently delete this session?',
      name: 'deleteSessionConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Delete Session`
  String get deleteSession {
    return Intl.message(
      'Delete Session',
      name: 'deleteSession',
      desc: '',
      args: [],
    );
  }

  /// `note`
  String get note {
    return Intl.message(
      'note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Add an item`
  String get addanitem {
    return Intl.message(
      'Add an item',
      name: 'addanitem',
      desc: '',
      args: [],
    );
  }

  /// `Cost price`
  String get costprice {
    return Intl.message(
      'Cost price',
      name: 'costprice',
      desc: '',
      args: [],
    );
  }

  /// `Edit Session`
  String get editSession {
    return Intl.message(
      'Edit Session',
      name: 'editSession',
      desc: '',
      args: [],
    );
  }

  /// `Price Expenses`
  String get priceExpenses {
    return Intl.message(
      'Price Expenses',
      name: 'priceExpenses',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Electricity`
  String get electricity {
    return Intl.message(
      'Electricity',
      name: 'electricity',
      desc: '',
      args: [],
    );
  }

  /// `Rent`
  String get rent {
    return Intl.message(
      'Rent',
      name: 'rent',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Water bill`
  String get waterBill {
    return Intl.message(
      'Water bill',
      name: 'waterBill',
      desc: '',
      args: [],
    );
  }

  /// `employees`
  String get employees {
    return Intl.message(
      'employees',
      name: 'employees',
      desc: '',
      args: [],
    );
  }

  /// `Select Type`
  String get selectType {
    return Intl.message(
      'Select Type',
      name: 'selectType',
      desc: '',
      args: [],
    );
  }

  /// `Add Expense`
  String get addExpense {
    return Intl.message(
      'Add Expense',
      name: 'addExpense',
      desc: '',
      args: [],
    );
  }

  /// `Update Expense`
  String get updateExpense {
    return Intl.message(
      'Update Expense',
      name: 'updateExpense',
      desc: '',
      args: [],
    );
  }

  /// `Expenses`
  String get expenses {
    return Intl.message(
      'Expenses',
      name: 'expenses',
      desc: '',
      args: [],
    );
  }

  /// `Special for adding procedures`
  String get specialForAddingOperations {
    return Intl.message(
      'Special for adding procedures',
      name: 'specialForAddingOperations',
      desc: '',
      args: [],
    );
  }

  /// `Inventory`
  String get inventory {
    return Intl.message(
      'Inventory',
      name: 'inventory',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Expiration Date`
  String get expirationDate {
    return Intl.message(
      'Expiration Date',
      name: 'expirationDate',
      desc: '',
      args: [],
    );
  }

  /// `Wholesale Price`
  String get wholesalePrice {
    return Intl.message(
      'Wholesale Price',
      name: 'wholesalePrice',
      desc: '',
      args: [],
    );
  }

  /// `Gain Price`
  String get gainPrice {
    return Intl.message(
      'Gain Price',
      name: 'gainPrice',
      desc: '',
      args: [],
    );
  }

  /// `Selling Price`
  String get sellingPrice {
    return Intl.message(
      'Selling Price',
      name: 'sellingPrice',
      desc: '',
      args: [],
    );
  }

  /// `Select Expiration Date`
  String get selectExpirationDate {
    return Intl.message(
      'Select Expiration Date',
      name: 'selectExpirationDate',
      desc: '',
      args: [],
    );
  }

  /// `Filter Expenses`
  String get filterExpenses {
    return Intl.message(
      'Filter Expenses',
      name: 'filterExpenses',
      desc: '',
      args: [],
    );
  }

  /// `Edit Expense`
  String get editExpense {
    return Intl.message(
      'Edit Expense',
      name: 'editExpense',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get pleaseEnterValidNumber {
    return Intl.message(
      'Please enter a valid number',
      name: 'pleaseEnterValidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a number`
  String get pleaseEnterNumber {
    return Intl.message(
      'Please enter a number',
      name: 'pleaseEnterNumber',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get end {
    return Intl.message(
      'End',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get startDate {
    return Intl.message(
      'Start',
      name: 'startDate',
      desc: '',
      args: [],
    );
  }

  /// `Patient Code`
  String get patientCode {
    return Intl.message(
      'Patient Code',
      name: 'patientCode',
      desc: '',
      args: [],
    );
  }

  /// `Sessions`
  String get sessions {
    return Intl.message(
      'Sessions',
      name: 'sessions',
      desc: '',
      args: [],
    );
  }

  /// `discardChanges`
  String get discardChanges {
    return Intl.message(
      'discardChanges',
      name: 'discardChanges',
      desc: '',
      args: [],
    );
  }

  /// `confirm`
  String get confirm {
    return Intl.message(
      'confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `clear Data Confirmation`
  String get clearDataConfirmation {
    return Intl.message(
      'clear Data Confirmation',
      name: 'clearDataConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to save the changes?`
  String get Doyouwanttosavethechanges {
    return Intl.message(
      'Do you want to save the changes?',
      name: 'Doyouwanttosavethechanges',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Add Procedures`
  String get addProcedures {
    return Intl.message(
      'Add Procedures',
      name: 'addProcedures',
      desc: '',
      args: [],
    );
  }

  /// `Procedures`
  String get procedures {
    return Intl.message(
      'Procedures',
      name: 'procedures',
      desc: '',
      args: [],
    );
  }

  /// `close procedures`
  String get closeprocedures {
    return Intl.message(
      'close procedures',
      name: 'closeprocedures',
      desc: '',
      args: [],
    );
  }

  /// `please select date`
  String get pleaseSelectDate {
    return Intl.message(
      'please select date',
      name: 'pleaseSelectDate',
      desc: '',
      args: [],
    );
  }

  /// `please select time`
  String get pleaseSelectTime {
    return Intl.message(
      'please select time',
      name: 'pleaseSelectTime',
      desc: '',
      args: [],
    );
  }

  /// `0%`
  String get zeroPercent {
    return Intl.message(
      '0%',
      name: 'zeroPercent',
      desc: '',
      args: [],
    );
  }

  /// `Net Profit`
  String get netProfit {
    return Intl.message(
      'Net Profit',
      name: 'netProfit',
      desc: '',
      args: [],
    );
  }

  /// `Total Price Material`
  String get totalPriceMaterial {
    return Intl.message(
      'Total Price Material',
      name: 'totalPriceMaterial',
      desc: '',
      args: [],
    );
  }

  /// `Total Price Expenses`
  String get totalPriceExpenses {
    return Intl.message(
      'Total Price Expenses',
      name: 'totalPriceExpenses',
      desc: '',
      args: [],
    );
  }

  /// `Total Price Patient`
  String get totalPricePatient {
    return Intl.message(
      'Total Price Patient',
      name: 'totalPricePatient',
      desc: '',
      args: [],
    );
  }

  /// `Value`
  String get value {
    return Intl.message(
      'Value',
      name: 'value',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Select a period for the budget`
  String get selectBudgetPeriod {
    return Intl.message(
      'Select a period for the budget',
      name: 'selectBudgetPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Prescription`
  String get Prescription {
    return Intl.message(
      'Prescription',
      name: 'Prescription',
      desc: '',
      args: [],
    );
  }

  /// `Save & Download Prescription`
  String get DownloadPrescription {
    return Intl.message(
      'Save & Download Prescription',
      name: 'DownloadPrescription',
      desc: '',
      args: [],
    );
  }

  /// `Habits`
  String get habits {
    return Intl.message(
      'Habits',
      name: 'habits',
      desc: '',
      args: [],
    );
  }

  /// `Surgical History`
  String get surgicalHistory {
    return Intl.message(
      'Surgical History',
      name: 'surgicalHistory',
      desc: '',
      args: [],
    );
  }

  /// `Lab`
  String get lab {
    return Intl.message(
      'Lab',
      name: 'lab',
      desc: '',
      args: [],
    );
  }

  /// `Diagnosis`
  String get diagnosis {
    return Intl.message(
      'Diagnosis',
      name: 'diagnosis',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
