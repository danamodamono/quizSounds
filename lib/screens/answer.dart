import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:soundpool/soundpool.dart';

class Answer extends StatefulWidget {
  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  List<String> _texts = [
    "回答１",
    "回答２",
    "ガーン１",
    "ガーン２",
    "イャッホー",
    "やった！",
  ];

  List<int> _soundIds = [0, 0, 0, 0, 0, 0];

  Soundpool? _soundpool;

  @override
  void initState() {
    super.initState();
    _initSounds();
  }

  Future<void> _initSounds() async {
    try {
      _soundpool = Soundpool.fromOptions();

      _soundIds[0] = await loadSound("assets/sounds/sound07_tin.mp3");
      _soundIds[1] = await loadSound("assets/sounds/sound08_doramu.mp3");
      _soundIds[2] = await loadSound("assets/sounds/sound09_unmei.mp3");
      _soundIds[3] = await loadSound("assets/sounds/sound10_unmei2.mp3");
      _soundIds[4] = await loadSound("assets/sounds/sound11_yahho.mp3");
      _soundIds[5] = await loadSound("assets/sounds/sound12_yatta.mp3");

      print("soundIds: $_soundIds");

      setState(() {});
    } on IOException catch (error) {
      print("エラーの内容は：$error");
    }
  }

  Future<int> loadSound(String soundPath) {
    return rootBundle.load(soundPath).then((value) {
      if (_soundpool != null) {
        return _soundpool!.load(value);
      } else {
        return 0;
      }
    });
  }

  @override
  void dispose() {
    _soundpool?.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("回答者", style: TextStyle(fontSize:35.0,)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                        flex: 1, child: _soundButton(_texts[0], _soundIds[0])),
                    Expanded(
                        flex: 1, child: _soundButton(_texts[1], _soundIds[1])),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                        flex: 1, child: _soundButton(_texts[2], _soundIds[2])),
                    Expanded(
                        flex: 1, child: _soundButton(_texts[3], _soundIds[3])),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                        flex: 1, child: _soundButton(_texts[4], _soundIds[4])),
                    Expanded(
                        flex: 1, child: _soundButton(_texts[5], _soundIds[5])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _soundButton(String displayText, int soundId) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 25.0),
            primary: Colors.redAccent,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            )
        ),
        onPressed: () => _playSound(soundId),
        child: Text(displayText),
      ),
    );
  }

  void _playSound(int soundId) {
    _soundpool?.play(soundId);
    print("soundId: $soundId");
  }
}
