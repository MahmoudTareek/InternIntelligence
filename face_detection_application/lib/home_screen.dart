import 'dart:io';
import 'package:face_detection_application/Shared/Subscription_manager.dart';
import 'package:face_detection_application/Shared/trial_manager.dart';
import 'package:face_detection_application/live_face_detection_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'face_recognation.dart';

class Home_Screen extends StatefulWidget {
  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  final ImagePicker _picker = ImagePicker();
  final FaceRecognitionService _faceService = FaceRecognitionService();

  File? _image;
  int _faceCount = 0;

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final imageFile = File(picked.path);
    final faces = await _faceService.detectFaces(imageFile);

    setState(() {
      _image = imageFile;
      _faceCount = faces.length;
    });
  }

  @override
  void dispose() {
    _faceService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Face Detection")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null) Image.file(_image!, height: 500),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () async {
                bool subscribed = await SubscriptionManager.isSubscribed();

                if (subscribed) {
                  // Access feature directly
                  _pickImage();
                } else {
                  bool canUse = await TrialManager.useTrial(context);
                  if (canUse) {
                    _pickImage();
                  }
                }
              },
              child: Text(
                "Pick an Image",
                style: TextStyle(color: Colors.white),
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: () async {
                bool subscribed = await SubscriptionManager.isSubscribed();

                if (subscribed) {
                  // Access feature directly
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Live_Detection_Screen(),
                    ),
                  );
                } else {
                  bool canUse = await TrialManager.useTrial(context);
                  if (canUse) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Live_Detection_Screen(),
                      ),
                    );
                  }
                }
              },

              child: Text(
                "Live Camera Detection",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            Text("Detected Faces: $_faceCount"),
            ElevatedButton.icon(
              onPressed: () async {
                await SubscriptionManager.unsubscribe();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("You are now Unsubscribed!")),
                );
              },
              icon: Icon(Icons.payment),
              label: Text("Unsubscribe"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
