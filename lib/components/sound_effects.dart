/// These are simple functions for playing sound effects.
import 'package:audioplayers/audioplayers.dart';

/// Plays the 'click.wav' sound from assets.
void playClick() async {
  final player = AudioPlayer();
  await player.play(AssetSource('click.wav'));
}

/// Plays the 'dialog.wav' sound from assets.
void playDialog() async {
  final player = AudioPlayer();
  await player.play(AssetSource('dialog.wav'));
}
