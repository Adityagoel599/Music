import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:music/models/songs.dart';

class playlistProvider extends ChangeNotifier{

  final List<Song>_playlist=[
  Song(
    songName: "Cheque",
    artistName:"Shubh",
    albumArtImagePath: "assets/image/cheque.jpg",
    audioPath: "assets/audio/Cheques.mp3"

  ),
    Song(songName: "Brief", artistName: "Zehr Vibe", albumArtImagePath:"assets/image/maxresdefault.jpg", audioPath: "assets/audio/brief.mp3")
  ];
int ? _currentSongIndex;
final AudioPlayer _audioPlayer=AudioPlayer();
Duration _currentduration= Duration.zero;
Duration _totalduration= Duration.zero;
playlistProvider(){
  listentoDuration();
}
bool _isplaying= false;

void play()async{
  final String path =_playlist[_currentSongIndex!].audioPath;
//final String path="audio/Cheques.mp3";
  await _audioPlayer.stop();
await _audioPlayer.play(AssetSource(path));
_isplaying=true;
notifyListeners();
}
void pause () async{
  await _audioPlayer.pause();
  _isplaying= false;
  notifyListeners();
  }
  void resume () async{
    await _audioPlayer.resume();
    _isplaying= true;
    notifyListeners();
  }
  void seek(Duration position) async{
  await _audioPlayer.seek(position);
  }
  void playnextsong() async{
  if(_currentSongIndex!=null){
    if(_currentSongIndex!<playlist.length-1){
      currentSongIndex= _currentSongIndex! + 1;

    }else{
      currentSongIndex=0;
    }
  }
  }
  void playprevious()async{
  if (_currentduration.inSeconds<2){
    currentSongIndex=_currentSongIndex;
  }
  else{
   if(_currentSongIndex!>0){
    currentSongIndex=_currentSongIndex!-1;
  }else{
     currentSongIndex=playlist.length-1;
   }
  }
  }
  void pauseorresume()async{
  if(_isplaying){
    pause();
   // _isplaying=false;
  }else{
    resume();
   // _isplaying=true;
  }
  notifyListeners();
  }


  void listentoDuration(){
_audioPlayer.onDurationChanged.listen((newduration){
  _totalduration=newduration  ;
  notifyListeners();
});
_audioPlayer.onPositionChanged.listen((newPosition){
  _currentduration=newPosition;
  notifyListeners();
});
_audioPlayer.onPlayerComplete.listen((event){ playnextsong();});
}
List<Song> get playlist => _playlist;
// getter
int? get currentSongIndex=> _currentSongIndex;
bool get isPlaying=> _isplaying;
Duration get totalDuration=>_totalduration;
Duration get currentDuration=> _currentduration;
// setter
set currentSongIndex(int? newIndex){
  _currentSongIndex= newIndex;
  if(newIndex!=null){
    play();
  }
  notifyListeners();
}
}
