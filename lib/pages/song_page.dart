//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';
import 'package:music/components/neu_box.dart';
import 'package:music/models/playlist_provider.dart';
import 'package:provider/provider.dart';
class SongPage extends StatelessWidget {
  const SongPage({super.key});
  String formatTime(Duration duration){
    String twoDigitsSeconds  = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    String formattedTime= "${duration.inMinutes}:$twoDigitsSeconds";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<playlistProvider>(builder: (context, value, child ) {

        final playlist= value.playlist;
       final currentSong= playlist[value.currentSongIndex?? 0];

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,

        body:SafeArea(
          child:Padding(
            padding: EdgeInsets.only(left: 25, right:25, bottom:25),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  IconButton(onPressed: ()=> Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
                  const Text("P L A Y I N G"),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.menu))

                ],),
                const SizedBox(height: 25,),
                NeuBox(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child:Image.asset(currentSong.albumArtImagePath),
                        ),
                        Padding(padding:  const EdgeInsets.all(15),
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(currentSong.songName, style: TextStyle( fontWeight:FontWeight.bold, fontSize:20)),
                                  Text(currentSong.artistName),

                                ],
                              ),
                              const Icon(Icons.favorite, color: Colors.red,)
                            ],
                          ),
                        )
                      ]
                  ),

                ),
                const SizedBox(height: 20,),
                Column(
                    children: [
                      Padding(padding:  const EdgeInsets.symmetric(horizontal: 25.0),
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatTime(value.currentDuration)),
                            Icon(Icons.shuffle),
                            Icon(Icons.repeat),
                            Text(formatTime(value.totalDuration))
                          ],
                        ),),
                      SliderTheme(data:SliderTheme.of(context).copyWith(
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),

                      ) , child:
                      Slider(
                          min: 0,
                          max: value.totalDuration.inSeconds.toDouble(),
                          activeColor: Colors.green,
                          // check according to the comments

                          value: value.currentDuration.inSeconds.toDouble(),
                        onChanged: (val){
                      },
                        onChangeEnd: (val){
                            value.seek(Duration(seconds: val.toInt()));
                        },

                      )
                      )]
                ),
                const SizedBox(height: 25,),
                Row(
                  children: [
                    Expanded(child:GestureDetector(
                        onTap: value.playprevious,
                        child:
                        NeuBox(child:
                        Icon(Icons.skip_previous),

                        )
                    )
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                        flex: 2,
                        child:GestureDetector(
                            onTap: value.pauseorresume,
                            child:
                            NeuBox(child:
                            Icon(value.isPlaying? Icons.pause: Icons.play_arrow),

                            )
                        )
                    ),
                    const SizedBox(width: 20,),
                    Expanded(

                        child:GestureDetector(
                            onTap: value.playnextsong,
                            child:
                           const NeuBox(child:
                            Icon(Icons.skip_next),

                            )
                        )
                    )
                  ],
                )

              ],
            ),
          ),
        ),
      );
    }
    );
  }
}



// faltu

//   Padding(
//     padding:  const EdgeInsets.all(15),
// child: Row(
//   children: [
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//        Text("Cheque", style: TextStyle( fontWeight:FontWeight.bold, fontSize:20)
//          ,),
//        Text("Shubh"),
//       ],
//     ),
//     Icon(Icons.favorite, color: Colors.red,)

// );