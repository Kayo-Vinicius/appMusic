import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicApp(),
    );
  }
}

class MusicApp extends StatefulWidget {
  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  //FUNÇÕES BOTÃO PLAY
  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  AudioPlayer _player;
  AudioCache cache;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          activeColor: Colors.black,
          inactiveColor: Color.fromARGB(28, 122, 121, 121),
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    //FUNÇÃO QUE MOSTRA O TEMPO DA MUSICA
    _player.durationHandler = (d) {
      setState(() {
        musicLength = d;
      });
    };

    //FUNÇÃO DE MOVER O CURSOR DO TEMPO DA MUSICA
    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };

    //NOME DO ARQUIVO DA MUSICA
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(30, 139, 202, 1),
                Color.fromARGB(255, 44, 16, 206),
              ]),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 48.0,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    'Music Beats',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Center(
                  child: Text(
                    'Musicas favoritas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                //IMAGEM DA MUSICA
                SizedBox(
                  height: 24.0,
                ),
                Center(
                  child: Container(
                    width: 250.0,
                    height: 250.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/f73b5282831eafe777eb4b589c941beb.jpg'),
                        )),
                  ),
                ),

                //NOME DA MUSICA
                SizedBox(
                  height: 18.0,
                ),
                Center(
                  child: Text('Heroes Tonight',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.w600,
                      )),
                ),

                //CONTROLES DA MUSICA
                SizedBox(
                  height: 30.0,
                ),

                Center(
                  child: Expanded(
                    child: Container(
                      height: 250.0,
                      width: 380.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //ADICIONANDO OS CONTROLES
                          Container(
                            width: 400.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                slider(),
                                Text(
                                    "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}"),
                              ],
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 45.0,
                                color: Colors.black,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.skip_previous,
                                ),
                              ),
                              IconButton(
                                iconSize: 60.0,
                                color: Colors.black,
                                //FUNÇÕES DO BOTÃO DE PLAY
                                onPressed: () {
                                  if (!playing) {
                                    cache.play("Heroes Tonight(MP3_160K).mp3");
                                    setState(() {
                                      playBtn = Icons.pause;
                                      playing = true;
                                    });
                                  } else {
                                    _player.pause();
                                    setState(() {
                                      playBtn = Icons.play_arrow;
                                      playing = false;
                                    });
                                  }
                                },
                                icon: Icon(
                                  playBtn,
                                ),
                              ),
                              IconButton(
                                iconSize: 45.0,
                                color: Colors.black,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.skip_next,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
