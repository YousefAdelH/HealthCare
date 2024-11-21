// cloudinary_service.dart
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CloudinaryService {
  final String _cloudinaryUploadUrl =
      "https://api.cloudinary.com/v1_1/dfpelxxh1/upload";
  final String _cloudinaryDestroyUrl =
      "https://api.cloudinary.com/v1_1/dfpelxxh1/image/destroy";
  final String _uploadPreset = "vv8f0p8b"; // Replace with your actual preset
  final String _apiKey =
      "653859281682131"; // Replace with your Cloudinary API key
  final String _apiSecret =
      "jaNi_Z4vybqlg0sKu8446iWYNUs"; // Replace with your Cloudinary API secret

  /// Uploads a file to Cloudinary and returns the `secure_url` and `public_id`.
  Future<Map<String, String>?> uploadFileToCloudinary(File file) async {
    try {
      final request =
          http.MultipartRequest('POST', Uri.parse(_cloudinaryUploadUrl));
      request.files.add(await http.MultipartFile.fromPath('file', file.path));
      request.fields['upload_preset'] = _uploadPreset;
      request.fields['resource_type'] =
          'auto'; // Allows handling of multiple file types

      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final data = json.decode(responseData.body);
        return {
          'secure_url': data['secure_url'],
          'public_id': data['public_id'],
        };
      } else {
        print("Failed to upload file to Cloudinary: ${responseData.body}");
        return null;
      }
    } catch (e) {
      print("Error uploading to Cloudinary: $e");
      return null;
    }
  }

  /// Deletes a file from Cloudinary using its `public_id`.
  Future<bool> deleteImageFromCloudinary(String publicId) async {
    try {
      final response = await http.post(
        Uri.parse(_cloudinaryDestroyUrl),
        body: {
          "public_id": publicId,
          "invalidate": "true",
        },
        headers: {
          "Authorization":
              "Basic ${base64Encode(utf8.encode('$_apiKey:$_apiSecret'))}",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      if (response.statusCode == 200) {
        print("Image deleted successfully from Cloudinary.");
        return true;
      } else {
        print("Failed to delete image from Cloudinary: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error deleting image: $e");
      return false;
    }
  }
}
