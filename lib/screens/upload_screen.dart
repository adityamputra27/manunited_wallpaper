import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as PATH;

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  CollectionReference? sourcesReference;

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    String extension = PATH.extension(result!.files.first.name);

    if (extension.toLowerCase() == '.mp4') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'File not valid',
          ),
        ),
      );
      setState(() {
        pickedFile = null;
        uploadTask = null;
      });
    } else {
      setState(() {
        pickedFile = result.files.first;
      });
    }
  }

  Future<void> uploadFile() async {
    if (pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select file',
          ),
        ),
      );
    } else {
      String extension = PATH.extension(pickedFile!.name);

      if (extension.toLowerCase() == '.mp4') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'File not valid',
            ),
          ),
        );
      } else {
        final path = 'wallpapers/${pickedFile!.name}';
        final file = File(pickedFile!.path!);
        final ref = FirebaseStorage.instance.ref().child(path);

        setState(() {
          uploadTask = ref.putFile(file);
        });

        final snapshot = await uploadTask!.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        print('Download Link : ${urlDownload}');

        sourcesReference?.add({'url': urlDownload});

        setState(() {
          uploadTask = null;
        });
      }
    }
  }

  Future<void> resetFile() async {
    setState(() {
      pickedFile = null;
      uploadTask = null;
    });
  }

  @override
  void initState() {
    super.initState();
    sourcesReference = FirebaseFirestore.instance.collection('sources');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Upload Files',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (pickedFile != null)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 20),
                  child: Image.file(
                    File(pickedFile!.path!),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (uploadTask != null) buildProgress(),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.folder,
                color: Colors.white,
              ),
              onPressed: selectFile,
              label: const Text(
                'SELECT FILE',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.upload,
              ),
              onPressed: uploadFile,
              label: const Text('UPLOAD FILE'),
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.refresh,
              ),
              onPressed: resetFile,
              label: const Text('RESET FILE'),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              height: 25,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.red,
                  ),
                  Center(
                    child: Text(
                      '${(100 * progress).roundToDouble()}%',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      );
}
