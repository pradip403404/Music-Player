import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Music Player",
        home: const MusicPlayer(),
        theme: ThemeData(
          canvasColor: Colors.pink,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
          ),
        ));
  }
}

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  @override
  Widget build(BuildContext context) {
    final assetPlayer = AudioPlayer();
    final networkPlayer = AudioPlayer();
    final double _position = 0.0;
    bool isPlaying = false;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "Music Player",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.transparent,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (!isPlaying) {
                        assetPlayer.play(AssetSource('music/note3.mp3'));
                        setState(() {
                          isPlaying = true;
                        });
                      } else {
                        assetPlayer.pause();
                        setState(() {
                          isPlaying = false;
                        });
                      }
                    },
                    child: Text(isPlaying ? "Pause" : "Play"),
                  ),
                  if (isPlaying)
                    Align(
                      alignment: Alignment.center,
                      child: LinearProgressIndicator(
                        value: _position,
                        backgroundColor: Colors.black26,
                      ),
                    ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                assetPlayer.play(AssetSource("music/airtel.mp3"));
              },
              child: const Icon(Icons.skip_next),
            ),
            ElevatedButton(
              onPressed: () {
                assetPlayer.play(
                  AssetSource('music/cheshta.mp3'),
                );
              },
              child: const Icon(Icons.skip_previous),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (!isPlaying) {
                    await networkPlayer.play(UrlSource(
                        'https://thegrowingdeveloper.org/files/audios/quiet-time.mp3?b4869097e4'));
                    setState(() {
                      isPlaying = true;
                    });
                  } else {
                    await networkPlayer.pause();
                    setState(() {
                      isPlaying = false;
                    });
                  }
                },
                child: Text(isPlaying ? "Pause" : "Play")),
          ],
        ),
      ),
    );
  }
}
