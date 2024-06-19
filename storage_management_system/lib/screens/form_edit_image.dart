import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class FormEditImage extends StatefulWidget {
  final int id;
  const FormEditImage({super.key, required this.id});

  @override
  State<FormEditImage> createState() => _FormEditImageState();
}

class _FormEditImageState extends State<FormEditImage> {
  String? pathFiles;
  String? password;
  String message = '';

  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: const Icon(Icons.person),
        title: const Text('Change Image'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        children: [
          message.isEmpty
              ? SizedBox(
                  height: sizeWidth,
                  width: sizeWidth / 2,
                  child: pathFiles != null
                      ? Image.file(File(pathFiles!))
                      : Placeholder(),
                )
              : Text(message),
          const SizedBox(height: 10),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              onPressed: () {
                captureImage();
              },
              child: const Text('Upload Image')),
          const SizedBox(height: 10),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              onPressed: () {
                if (pathFiles != null) {
                  uploadImage();
                } else {
                  setState(() {
                    message = "Please select an image first!";
                  });
                }
              },
              child: const Text('Save Image')),
          const SizedBox(height: 10),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back')),
        ],
      ),
    );
  }

  Future captureImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pathFiles = image.path;
      });
    }
  }

  Future<void> uploadImage() async {
    try {
      if (pathFiles != null && pathFiles!.isNotEmpty) {
        var id = widget.id;
        var url = 'http://192.168.1.6:3000';

        var formData = FormData();
        formData.fields.addAll([
          MapEntry('password', password ?? ''),
        ]);
        formData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(
            pathFiles!,
            filename: path.basename(pathFiles!),
          ),
        ));

        var response = await Dio().patch(
          '$url/users/$id',
          data: formData,
          options: Options(
            contentType: 'multipart/form-data',
          ),
        );

        if (response.statusCode == 200) {
          setState(() {
            message = "Image uploaded successfully";
          });

          Navigator.pop(context);
        }
      }
    } on DioException catch (e) {
      print('Error: ${e.message}');
    }
  }
}
