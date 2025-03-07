import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SetWallpaper extends StatefulWidget {
  const SetWallpaper({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  State<SetWallpaper> createState() => _SetWallpaperState();
}

class _SetWallpaperState extends State<SetWallpaper> {
  
  Future<void> setwallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;

    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    final result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);

        if(result){
          Fluttertoast.showToast(msg: 'Wallpaper Updated');
        }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(child: Container(child: Image.network(widget.imageUrl))),
            InkWell(
              onTap: () {
                setwallpaper();
              },
              child: Container(
                height: 60,
                width: double.infinity,
                child: Center(
                  child: const Text(
                    'Save Wallpaper',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
