import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:soundpool/soundpool.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  List<String> _texts = [
    "出題１",
    "出題２",
    "正解",
    "不正解",
    "急げ急げ",
    "へいへい",
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

      _soundIds[0] = await loadSound("assets/sounds/sound01_deden.mp3");
      _soundIds[1] = await loadSound("assets/sounds/sound02_next.mp3");
      _soundIds[2] = await loadSound("assets/sounds/sound03_correct.mp3");
      _soundIds[3] = await loadSound("assets/sounds/sound04_not.mp3");
      _soundIds[4] = await loadSound("assets/sounds/sound05_warning.mp3");
      _soundIds[5] = await loadSound("assets/sounds/sound06_aori.mp3");

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
        title: Text("出題者", style: TextStyle(fontSize:35.0,)),
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
            primary: Colors.blueAccent,
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
