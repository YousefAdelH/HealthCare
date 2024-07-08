import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeCtrl extends GetxController {
  var currentImage = 'assets/img/3.png'.obs;
  var currentName = 'Yousef Adel Habile'.obs;

  void changeImage(String newImage) {
    currentImage.value = newImage;
  }

  void changeName(String newName) {
    currentName.value = newName;
  }

  void pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      print('Selected file path: ${file.path}');
      // Example: update the current image in the controller
      changeImage(file.path!);
    } else {
      // User canceled the file picker
    }
  }

  void showChangeName(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Name and Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "Enter new name"),
              ),
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(
                onPressed: () {
                  changeName(nameController.text);
                  Navigator.of(context).pop();
                },
                child: const Text('Change Name'),
              ),
            ],
          ),
        );
      },
    );
  }
  // void showChangeImage(BuildContext context) {
  //   final TextEditingController nameController = TextEditingController();

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Change Image'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ElevatedButton(
  //               onPressed: () {
  //                 pickImage();
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('Change Image'),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
