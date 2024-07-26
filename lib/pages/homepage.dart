import 'package:flutter/material.dart';
import 'package:music/components/my_drawer.dart';
import 'package:music/models/playlist_provider.dart';
import 'package:music/models/songs.dart';
import 'package:music/pages/song_page.dart';
import 'package:provider/provider.dart';
class Homepage extends StatefulWidget{
  const  Homepage({super.key});
  @override
  State<Homepage> createState()=>_HomepageState();

}
class _HomepageState extends State<Homepage>{
  late final dynamic playlistprovider;
  @override
  void initState(){
    super.initState();
    playlistprovider= Provider.of<playlistProvider>(context, listen : false);
  }
  void gotoSong(int songindex ){
playlistprovider.currentSongIndex= songindex;
Navigator.push(context, MaterialPageRoute(builder: (context)=>SongPage()));
  }
  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text("P L A Y L I S T"),),
      drawer: MyDrawer(),
      body: Consumer<playlistProvider>(
        builder: (context,value,child){
          // getting the playlist
          final List<Song>playlist = value.playlist;
        return ListView.builder(
            itemCount: playlist.length,
            itemBuilder:( context, index)
            {
              final Song song=playlist[index];
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumArtImagePath),
               onTap: ()=> gotoSong(index),
              );}
        ); } ,

      ),
    );
  }
}