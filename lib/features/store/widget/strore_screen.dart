import 'package:dental_app/features/store/controller/store_controller.dart';
import 'package:dental_app/features/store/widget/add_material_screen.dart';
import 'package:dental_app/features/store/widget/card_material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StroreScreen extends StatelessWidget {
  final MaterialController materialController = Get.put(MaterialController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dental Materials')),
      body: Obx(() {
        if (materialController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final materials = materialController.materials;
        return ListView.builder(
          itemCount: materials.length,
          itemBuilder: (context, index) {
            return CardMaterial(material: materials[index]);
            //  ListTile(
            //   title: Text(material.name),
            //   subtitle: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text('Quantity: ${material.quantity}'),
            //       Text('Wholesale Price: ${material.wholesalePrice}'),
            //       Text('Selling Price: ${material.sellingPrice}'),
            //       Text('Gain Price: ${material.gainPrice}'),
            //       Text('Expires: ${material.expirationDate}'),
            //     ],
            //   ),
            //   trailing: isExpiringSoon
            //       ? Icon(Icons.warning, color: Colors.red)
            //       : IconButton(
            //           icon: Icon(Icons.delete),
            //           onPressed: () =>
            //               materialController.deleteMaterial(material.id),
            //         ),
            //   onTap: () => Get.to(AddMaterialScreen(material: material)),
            // );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.to(AddMaterialScreen()),
      ),
    );
  }
}
