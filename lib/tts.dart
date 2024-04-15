
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tts_stt_demo/util.dart';

class TTSPage extends StatefulWidget {
  const TTSPage({super.key});

  @override
  State<StatefulWidget> createState() => _TTSPageState();

}

class _TTSPageState extends State<StatefulWidget> {
  final TextEditingController _textController = TextEditingController();

  late TTSUtil _ttsUtil;

  @override
  void initState() {
    super.initState();
    _ttsUtil = TTSUtil();
    _ttsUtil.initTTS();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            style: const TextStyle(fontSize: 20),
            decoration:const  InputDecoration(
              labelText: "输入文本",
              hintText: "需要转为语音的文本",

            ),
            controller: _textController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(Icons.surround_sound_outlined,size: 50,),
              TextButton(onPressed: toTTS, child: const Text("点击收听音频",style: TextStyle(fontSize: 30),))
            ],
          )
        ],
      ),
    );
  }

  void toTTS() {
    _ttsUtil.stop();
    _ttsUtil.speak(_textController.text);
  }

}