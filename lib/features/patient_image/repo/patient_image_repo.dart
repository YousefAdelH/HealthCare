import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/core/utlis/cloudinary_service.dart';
import 'package:image_picker/image_picker.dart';

class ImageRepository {
  final FirebaseFirestore _firestore;
  final CloudinaryService _cloudinaryService;

  ImageRepository(this._firestore, this._cloudinaryService);

  Future<String?> uploadImage(String patientId, File file) async {
    try {
      // Upload image to Cloudinary
      final uploadResponse =
          await _cloudinaryService.uploadFileToCloudinary(file);
      if (uploadResponse != null) {
        final imageUrl = uploadResponse['secure_url'];
        final publicId = uploadResponse['public_id'];

        // Save the image URL to Firestore
        await saveImageUrlToFirestore(patientId, imageUrl!);

        return imageUrl;
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
    return null;
  }

  Future<void> saveImageUrlToFirestore(
      String patientId, String imageUrl) async {
    try {
      final docRef = _firestore.collection('patient').doc(patientId);
      await docRef.update({
        'images': FieldValue.arrayUnion([imageUrl]),
      });
    } catch (e) {
      print("Failed to store image URL in Firestore: $e");
    }
  }

  ///////////////////delete /////////////
  Future<bool> deleteImage(String patientId, String publicId) async {
    try {
      // Delete image from Cloudinary
      final isDeleted =
          await _cloudinaryService.deleteImageFromCloudinary(publicId);
      if (isDeleted) {
        // Remove the image URL from Firestore
        await removeImageUrlFromFirestore(patientId, publicId);
        return true;
      }
    } catch (e) {
      print("Error deleting image: $e");
    }
    return false;
  }

  Future<void> removeImageUrlFromFirestore(
      String patientId, String publicId) async {
    try {
      final docRef = _firestore.collection('patients').doc(patientId);
      // Assuming the image URLs are stored with the public_id in the URL
      await docRef.update({
        'images': FieldValue.arrayRemove([publicId]),
      });
    } catch (e) {
      print("Error removing image URL from Firestore: $e");
    }
  }
}
// class ImageRepository {
//   final FirebaseFirestore _firestore;
//   final FirebaseStorage _firestorage;

//   // ImageRepository(this._storage, this._firestore);
//   ImageRepository(this._firestorage, this._firestore);

//   Future<String?> uploadImage(String patientId) async {
//     try {
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         final file = File(pickedFile.path);
//         final storageRef = _firestorage
//             .ref()
//             .child('patient/$patientId/${DateTime.now()}.jpg');
//         final uploadTask = storageRef.putFile(file);
//         final snapshot = await uploadTask;
//         return await snapshot.ref.getDownloadURL();
//       }
//     } catch (e) {
//       print("Failed to upload image: $e");
//       return null;
//     }
//     return null;
//   }

//   Future<void> saveImageUrlToFirestore(
//       String patientId, String imageUrl) async {
//     try {
//       final docRef = _firestore.collection('patient').doc(patientId);
//       await docRef.update({
//         'images': FieldValue.arrayUnion([imageUrl]),
//       });
//     } catch (e) {
//       print("Failed to store image URL in Firestore: $e");
//     }
//   }
// }
