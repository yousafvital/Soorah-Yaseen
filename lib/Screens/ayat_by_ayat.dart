import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:just_audio/just_audio.dart';

class AyatByAyatScreen extends StatefulWidget {
  const AyatByAyatScreen({super.key});

  @override
  State<AyatByAyatScreen> createState() => _AyatByAyatScreenState();
}

class _AyatByAyatScreenState extends State<AyatByAyatScreen>
    with SingleTickerProviderStateMixin {
  List<dynamic> ayatData = [];
  bool isLoading = true;
  bool hasError = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? playingIndex;
  Map<int, bool> isExpanded = {};

  @override
  void initState() {
    super.initState();
    loadAyatData();
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed ||
          state.processingState == ProcessingState.idle) {
        setState(() {
          playingIndex = null;
        });
      }
    });
  }

  Future<void> loadAyatData() async {
    try {
      final String response =
          await rootBundle.rootBundle.loadString('assets/json/surah.json');
      final data = json.decode(response);
      setState(() {
        ayatData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      print("Error loading JSON data: $e");
    }
  }

  Future<void> playAudio(String audioPath, int index) async {
    if (playingIndex == index) {
      await _audioPlayer.stop();
      setState(() {
        playingIndex = null;
      });
    } else {
      try {
        await _audioPlayer.setAsset(audioPath);
        _audioPlayer.play();
        setState(() {
          playingIndex = index;
        });
      } catch (e) {
        print("Error playing audio: $e");
      }
    }
  }

  void toggleTafsirAndPlayAudio(int index, String audioPath) {
    setState(() {
      isExpanded[index] = !(isExpanded[index] ?? false);
    });
    playAudio(audioPath, index);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'آیات',
          style: TextStyle(
            color: Color.fromARGB(255, 176, 151, 61),
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Noori',
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background3.png',
              fit: BoxFit.contain,
            ),
          ),
          // Main content
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : hasError
                  ? const Center(
                      child: Text(
                        "Failed to load data. Please check your file and try again.",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : AnimationLimiter(
                      child: ListView.builder(
                        itemCount: ayatData.length,
                        itemBuilder: (context, index) {
                          final ayat = ayatData[index];
                          final isSelected = index == playingIndex;
                          final isCardExpanded = isExpanded[index] ?? false;
                          final icon = isCardExpanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down;

                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 44.0,
                              child: FadeInAnimation(
                                child: InkWell(
                                  onTap: () {
                                    final audioPath =
                                        'assets/audios/ayat_audios/m${ayat['id']}.mp3';
                                    toggleTafsirAndPlayAudio(index, audioPath);
                                  },
                                  child: Card(
                                    color: isSelected
                                        ? const Color.fromARGB(
                                            250, 231, 233, 196)
                                        : const Color.fromARGB(
                                            222, 255, 255, 255),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            ayat['text'] ?? '',
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Quran'),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            ayat['translate'] ?? '',
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Color.fromARGB(
                                                    255, 48, 90, 110),
                                                fontFamily: 'Noori'),
                                          ),
                                          const SizedBox(height: 10),
                                          AnimatedSize(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeInOut,
                                            child: isCardExpanded &&
                                                    ayat['tafsir'] != null &&
                                                    ayat['tafsir'].isNotEmpty
                                                ? Column(
                                                    children: [
                                                      Text(
                                                        ayat['tafsir'] ?? '',
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black87,
                                                            fontFamily:
                                                                'Noori'),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                    ],
                                                  )
                                                : const SizedBox.shrink(),
                                          ),
                                          const SizedBox(height: 10),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(icon,
                                                    color: isSelected
                                                        ? Colors.green
                                                        : Colors.grey),
                                                const SizedBox(width: 4),
                                                Text(
                                                  ayat['id']?.toString() ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
