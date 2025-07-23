import 'dart:io'; // File operations k liye
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // HTTP requests k liye
import 'package:image_picker/image_picker.dart'; // Image picker
import 'package:path/path.dart'; // File name nikalne k liye

class UploadImagePage extends StatefulWidget {
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  File? _imageFile; // Yeh file hold karega user ki selected image
  final ImagePicker _picker = ImagePicker(); // Image pick karne k liye picker object

  // 🔹 Step 1: Image pick karna gallery se
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // Gallery se image uthao
    );

    if (pickedFile != null) {
      // Agar user ne image select ki
      setState(() {
        _imageFile = File(pickedFile.path); // File object bana lo
      });
    }
  }

  // 🔹 Step 2: Image ko REST API pe upload karna
  Future<void> _uploadImage(BuildContext context) async {
    if (_imageFile == null) return; // Agar koi image select nahi hui to return karo

    // 🔸 API ka URL jahan pe image upload hogi
    var uri = Uri.parse("https://fakestoreapi.com/products");

    // 🔸 Multipart request banate hain
    var request = http.MultipartRequest('POST', uri);

    // 🔸 Image ko MultipartFile mein convert karte hain aur request mein add karte hain
    request.files.add(
      await http.MultipartFile.fromPath(
        'file', // yeh wo key hai jo backend expect kar raha hai
        _imageFile!.path,
        filename: basename(_imageFile!.path), // File ka naam
      ),
    );

    // 🔸 Request bhejte hain
    var response = await request.send(); // Await is important

    // 🔸 Response check karte hain
    if (response.statusCode == 200) {
      print("  Image uploaded successfully");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image uploaded successfully!")),
      );
    } else {
      print("  Upload failed with status: ${response.statusCode}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload failed. Try again.")),
      );
    }
  }

  // 🔹 UI Section
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Image")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show selected image preview
            _imageFile != null
                ? Image.file(_imageFile!, height: 200)
                : Text("No image selected"),
            SizedBox(height: 20),

            // Button to pick image
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Pick Image from Gallery"),
            ),

            // Button to upload image
            ElevatedButton(
              onPressed:() async{
                await _uploadImage(context);
              },
              child: Text("Upload to Server"),
            ),
          ],
        ),
      ),
    );
  }
}
