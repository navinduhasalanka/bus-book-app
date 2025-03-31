import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  
  @override
  State createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  
  // Function to pick image from gallery with improved error handling
  Future<void> _pickImageFromGallery() async {
    print("Attempting to pick image from gallery");
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85, // Good quality but not too large
      );
      
      print("Picked file path: ${pickedFile?.path}");
      
      if (pickedFile != null) {
        // Check if the file exists
        File file = File(pickedFile.path);
        bool exists = await file.exists();
        print("File exists: $exists");
        print("File size: ${await file.length()} bytes");
        print("File extension: ${pickedFile.path.split('.').last}");
        
        setState(() {
          _imageFile = file;
          print("Image file set successfully");
        });
      }
    } catch (e) {
      print("Error picking image: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error picking image: $e")),
        );
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: Colors.grey[300],
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30), // Space from top
              
              // Profile photo with gesture detector - FIXED IMAGE DISPLAY
              GestureDetector(
                onTap: () {
                  print("Tapped on profile picture");
                  _pickImageFromGallery().catchError((error) {
                    print("Error occurred: $error");
                    if (mounted) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Error"),
                          content: Text("Could not access gallery: $error"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  });
                },
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: ClipOval(
                      child: _imageFile != null
                          ? Image.file(
                              _imageFile!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                print("Error loading image: $error");
                                return Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey[400],
                                );
                              },
                            )
                          : Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey[400],
                            ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              const Text(
                'Profile Photo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Tap to change photo',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              
              // Display image path for debugging
              if (_imageFile != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Image path: ${_imageFile!.path}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}