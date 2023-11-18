import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:manunited_wallpaper/screens/file_screen.dart';
import 'package:path_provider/path_provider.dart';

class WallpaperListScreen extends StatefulWidget {
  const WallpaperListScreen({super.key});

  @override
  State<WallpaperListScreen> createState() => _WallpaperListScreenState();
}

class _WallpaperListScreenState extends State<WallpaperListScreen> {
  late Future<ListResult> futureFiles;
  Map<int, double> downloadProgres = {};

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/wallpapers').listAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Wallpapers',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<ListResult>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.items;
            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                double? progress = downloadProgres[index];
                return ListTile(
                  leading: FutureBuilder(
                    future: file.getDownloadURL(),
                    builder: (context, urlSnapshot) {
                      if (urlSnapshot.hasData) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FileScreen(
                                  url: urlSnapshot.data!,
                                ),
                              ),
                            );
                          },
                          child: Image.network(urlSnapshot.data!),
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  title: Text(file.name),
                  subtitle: progress != null
                      ? LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.black26,
                        )
                      : null,
                  trailing: IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () => downloadFile(index, file),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future downloadFile(int index, Reference ref) async {
    final url = await ref.getDownloadURL();

    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';
    await Dio().download(url, path, onReceiveProgress: (received, total) {
      double progress = received / total;

      setState(() {
        downloadProgres[index] = progress;
      });
    });

    await GallerySaver.saveImage(path,
        toDcim: true, albumName: 'Manchester United Wallpaper');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloaded ${ref.name}'),
      ),
    );

    setState(() {
      downloadProgres = {};
    });
  }
}
