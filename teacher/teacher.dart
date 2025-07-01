import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../my_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

class Teacher extends StatelessWidget {
  static const String routeName = 'teacher';
  List<CameraDescription> cameras = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        centerTitle: true,
        backgroundColor: MyTheme.primaryColor,
        title: Text(
          'Welcome prof.',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Student attendance:',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(MyTheme.lightBlue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: MyTheme.lightBlue),
                    ),
                  ),
                ),
                onPressed: () async {
                  await initCamera();
                  await takePicture();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Take Image',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(MyTheme.lightBlue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: MyTheme.lightBlue),
                    ),
                  ),
                ),
                onPressed: () async {
                  XFile? image = await pickImage();
                  if (image != null) {
                    // Send the picked image to the API
                    await sendImage(image);

                    print("Image picked from gallery: ${image.path}");
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Pick Image',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  }

  Future<void> takePicture() async {
    final CameraController controller = CameraController(
      cameras[0], // Use the first camera
      ResolutionPreset.medium,
    );

    await controller.initialize();

    final XFile file = await controller.takePicture();

    // Send the captured image to the API
    await sendImage(file);

    // Do something with the captured image file
    print("Image captured at: ${file.path}");

    await controller.dispose();
  }

  Future<XFile?> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }



  Future<void> sendImage(XFile imageFile) async {
    final String apiUrl = 'http://127.0.0.1:5000/your_image_upload_endpoint';

    // Open the image file
    final bytes = await imageFile.readAsBytes();

    // Create a multipart request
    final http.MultipartRequest request =
    http.MultipartRequest('POST', Uri.parse(apiUrl));

    // Attach the image file
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      bytes,
      filename: 'image.jpg',
    ));

    // Send the request
    final http.Response response =
    await http.Response.fromStream(await request.send());

    // Print the response
    print(response.body);
  }
}
