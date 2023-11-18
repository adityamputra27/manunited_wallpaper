import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manunited_wallpaper/firebase_options.dart';
import 'package:manunited_wallpaper/screens/upload_screen.dart';
import 'package:manunited_wallpaper/screens/wallpaper_list_screen.dart';
import 'package:manunited_wallpaper/screens/wallpaper_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 92, 0, 0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Manchester United Wallpaper'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              icon: const Icon(
                Icons.photo,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WallpaperScreen()),
                );
              },
              label: const Text(
                'ALL WALLPAPERS (GRIDVIEW)',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.photo,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WallpaperListScreen()),
                );
              },
              label: const Text(
                'ALL WALLPAPERS (LISTVIEW)',
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UploadScreen()),
                );
              },
              label: const Text('UPLOAD FILES'),
            ),
          ],
        ),
      ),
    );
  }
}
