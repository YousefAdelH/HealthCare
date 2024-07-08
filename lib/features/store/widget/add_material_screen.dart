import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/features/store/controller/store_controller.dart';
import 'package:dental_app/features/store/model/material_model.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddMaterialScreen extends StatelessWidget {
  final MaterialController con = Get.put(MaterialController());
  final _formKey = GlobalKey<FormState>();

  DentalMaterial? material;

  AddMaterialScreen({this.material}) {
    if (material != null) {
      con.getmatrial(material!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        con.deletecontroller();
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(material == null ? 'Add Material' : 'Update Material')),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: con.nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: con.quantityController,
                  decoration: InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: con.wholesalePriceController,
                  decoration: InputDecoration(labelText: 'Wholesale Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: con.sellingPriceController,
                  decoration: InputDecoration(labelText: 'Selling Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                //  DateTime? picked = await showDatePicker(
                //             context: context,
                //             initialDate: DateTime.now(),
                //             firstDate: DateTime(2000),
                //             lastDate: DateTime(2101),
                //           );
                //           if (picked != null && picked != con.sessionDate) {
                //             con.setSessionDate(picked);
                //           }
                TextButton(
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: con.expirationDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != con.expirationDate) {
                      con.setDate(picked);
                    }
                  },
                  child: Text('Select Expiration Date'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        con.expirationDate != null) {
                      final newMaterial = DentalMaterial(
                        id: material?.id ?? '',
                        name: con.nameController.text,
                        quantity: int.parse(con.quantityController.text),
                        expirationDate: DateFormat('yyyy-MM-dd')
                            .format(con.expirationDate!),
                        wholesalePrice:
                            double.parse(con.wholesalePriceController.text),
                        sellingPrice:
                            double.parse(con.sellingPriceController.text),
                      );

                      if (material == null) {
                        con.addMaterial(newMaterial);
                      } else {
                        con.updateMaterial(newMaterial);
                        con.nameController.clear();
                        con.quantityController.clear();
                        con.sellingPriceController.clear();
                        con.wholesalePriceController.clear();
                      }

                      Get.back();
                    }
                  },
                  child: Text(
                      material == null ? 'Add Material' : 'Update Material'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
