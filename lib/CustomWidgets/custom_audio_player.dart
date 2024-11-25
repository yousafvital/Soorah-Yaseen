import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class CustomAudioPlayer extends StatefulWidget {
  final String audioAsset;
  final PageController pageController;
  final bool isManual;

  const CustomAudioPlayer(
      {super.key,
      required this.audioAsset,
      required this.pageController,
      required this.isManual});

  static final List<AudioPlayer> _activePlayers = [];

  static void stopAllAudio() {
    for (var player in _activePlayers) {
      if (player.playing) {
        player.stop();
      }
    }
  }

  @override
  State<CustomAudioPlayer> createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    CustomAudioPlayer._activePlayers.add(player); // Register this player
  }

  Future<void> _initializePlayer() async {
    await player.setAsset(widget.audioAsset);

    //  print("Error playing audio: $e");
    if (!widget.isManual) {
      player.stop();
    }

    player.positionStream.listen((p) {
      setState(() {
        position = p;
      });
    });

    player.durationStream.listen((d) {
      setState(() {
        duration = d ?? Duration.zero;
      });
    });

    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          position = Duration.zero;
        });
        player.pause();
        player.seek(Duration.zero);

        // Trigger page change when audio is completed
        widget.pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void handlePlayPause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  void handleSeekBar(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }

  @override
  void dispose() {
    CustomAudioPlayer._activePlayers.remove(player); // Deregister this player
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 176, 151, 61).withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Replay button

          // Play/Pause button
          IconButton(
            icon: Icon(
              player.playing
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_fill,
              color: Colors.white,
              size: 28.0,
            ),
            onPressed: handlePlayPause,
          ),

          IconButton(
            icon: const Icon(Icons.replay_10, color: Colors.white),
            iconSize: 24,
            onPressed: () {
              final newPosition = position - const Duration(seconds: 10);
              player.seek(
                  newPosition > Duration.zero ? newPosition : Duration.zero);
            },
          ),
          // Forward button

          Text(
            _formatTime(position),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          // Seekbar
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white.withOpacity(0.5),
                thumbColor: Colors.amber,
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                overlayColor: Colors.amber.withOpacity(0.2),
                trackHeight: 2.5,
              ),
              child: Slider(
                min: 0.0,
                max: duration.inSeconds.toDouble(),
                value:
                    position.inSeconds.clamp(0, duration.inSeconds).toDouble(),
                onChanged: handleSeekBar,
              ),
            ),
          ),
          // Total duration
          Text(
            _formatTime(duration),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          IconButton(
            icon: const Icon(Icons.forward_10, color: Colors.white),
            iconSize: 24,
            onPressed: () {
              final newPosition = position + const Duration(seconds: 10);
              player.seek(newPosition < duration ? newPosition : duration);
            },
          ),
        ],
      ),
    );
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
