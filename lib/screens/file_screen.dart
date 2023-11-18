import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Download Wallpaper',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Image.network(
            widget.url,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            onPressed: () {
              GallerySaver.saveImage(widget.url,
                  toDcim: true, albumName: 'Manchester United Wallpaper');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Downloaded file successfully'),
                ),
              );
            },
            icon: const Icon(
              Icons.download,
              color: Colors.white,
            ),
            label: const Text(
              'SAVE TO GALLERY',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}
