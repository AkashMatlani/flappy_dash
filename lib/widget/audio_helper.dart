import 'package:flutter_soloud/flutter_soloud.dart';

class AudioHelper {
  late SoLoud _soLoud;
  late AudioSource _backgroundSource;
  SoundHandle? _playingBackground;
  late AudioSource _scoreSource;

  Future<void> initalize() async {
    _soLoud = SoLoud.instance;
    if (_soLoud.isInitialized) {
      return;
    }
    await _soLoud.init();
    _backgroundSource = await _soLoud.loadAsset('assets/game/background.mp3');
    _scoreSource= await _soLoud.loadAsset('assets/game/score.mp3');
  }

  void playBackgroundAudio()  {
    _playingBackground =  _soLoud.play(_backgroundSource);
    _soLoud.setProtectVoice(_playingBackground!, true);
  }

  void stopBackgroundAudio() {
    if (_playingBackground == null) {
      return;
    }
    _soLoud.fadeVolume(
        _playingBackground!, 0.0, const Duration(microseconds: 500));
  }

  void playScoreCollectSound(){
    _playingBackground =  _soLoud.play(_scoreSource);

  }
}
