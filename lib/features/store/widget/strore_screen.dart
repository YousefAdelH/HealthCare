import 'package:dental_app/features/store/controller/store_controller.dart';
import 'package:dental_app/features/store/widget/add_material_screen.dart';
import 'package:dental_app/features/store/widget/card_material.dart';
import 'package:dental_app/features/store/widget_mob/card_matrial_mob.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StroreScreen extends StatelessWidget {
  final MaterialController materialController = Get.put(MaterialController());

  @override
  Widget build(BuildContext context) {
    bool isMobile() {
      // Example condition: consider mobile if screen width is less than 600
      return MediaQuery.of(context).size.width < 600;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(() {
        if (materialController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final materials = materialController.materials;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemCount: materials.length,
            itemBuilder: (context, index) {
              if (isMobile()) {
                return CardMaterialMob(material: materials[index]);
              } else {
                return CardMaterial(material: materials[index]);
              }
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.to(AddMaterialScreen()),
      ),
    );
  }
}
