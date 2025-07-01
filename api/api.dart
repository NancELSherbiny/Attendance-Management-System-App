import 'package:http/http.dart' as http;

class VisionProjectApi {
  final String baseUrl;

  VisionProjectApi(this.baseUrl);

  Future<Map<String, dynamic>> uploadImage(String imagePath) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/upload'),
        body: {'file': imagePath},
      );

      if (response.statusCode == 200) {
        return {
          'message': 'File uploaded successfully',
          'imageBytes': response.bodyBytes,
        };
      } else {
        return {
          'error': 'Failed to upload image. Status code: ${response.statusCode}',
        };
      }
    } catch (error) {
      return {'error': 'Error uploading image: $error'};
    }
  }

  Future<Map<String, dynamic>> detectFaces(String imagePath) async {
    try {
      var response = await http.post(
        Uri.parse('$baseUrl/detect'),
        body: {'file': imagePath},
      );

      if (response.statusCode == 200) {
        return {
          'message': 'Face detection completed',
          'imageBytes': response.bodyBytes,
          'csvData': response.body,
        };
      } else {
        return {
          'error': 'Failed to detect faces. Status code: ${response.statusCode}',
        };
      }
    } catch (error) {
      return {'error': 'Error detecting faces: $error'};
    }
  }

}