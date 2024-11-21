import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCtrl extends GetxController {
  var currentImage = 'assets/img/3.png'.obs;
  var currentName = 'Yousef Adel Habile'.obs;
  @override
  void onInit() {
    super.onInit();
    loadImage();
  }

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
      saveImage(file.path!);
    } else {
      // User canceled the file picker
    }
  }

  Future<void> saveImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('imagePath', path);
  }

  Future<void> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    currentImage.value = prefs.getString('imagePath') ?? 'assets/img/3.png';
  }
  // void pickImage() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     allowMultiple: false,
  //   );

  //   if (result != null) {
  //     PlatformFile file = result.files.first;
  //     Uint8List? imageBytes = file.bytes;

  //     if (imageBytes != null) {
  //       print('Selected image size: ${imageBytes.length}');
  //       changeImage(imageBytes as String);
  //       saveImage(imageBytes);
  //     }
  //   } else {
  //     // User canceled the file picker
  //   }
  // }

  // // Save image bytes in SharedPreferences
  // Future<void> saveImage(Uint8List imageBytes) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('imageBytes', base64Encode(imageBytes));
  // }

  // // Load image bytes from SharedPreferences
  // Future<void> loadImage() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? imageBytesStr = prefs.getString('imageBytes');

  //   if (imageBytesStr != null) {
  //     Uint8List imageBytes = base64Decode(imageBytesStr);
  //     currentImage.value = imageBytes as String;
  //   } else {
  //     // Default image as bytes
  //     currentImage.value = (await rootBundle.load('assets/img/3.png'))
  //         .buffer
  //         .asUint8List() as String;
  //   }
  // }

  // // Display image with Image.memory
  // Widget buildImage() {
  //   return Obx(() => currentImage.value != null
  //       ? Image.memory(currentImage.value as Uint8List)
  //       : Image.asset('assets/img/3.png'));
  // }

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

  var titleAppBar = 'Home'.obs;
  void changeTitle(String title) {
    titleAppBar.value = title;
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
