import 'dart:developer';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'util.dart';

class STTPage extends StatefulWidget {
  const STTPage({super.key});

  @override
  State<StatefulWidget> createState() => _STTPageState();
}

// 有一个按钮做麦克风 按一次开启麦克风录音 再按一次关闭
class _STTPageState extends State<StatefulWidget> {
  bool _isListening = false;
  late STTUtil _sttUtil;
  late String _recordText;

  @override
  void initState() {
    super.initState();
    // 初始化STT工具类
    _sttUtil = STTUtil();
    _recordText = "请按下麦克风发起对话";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        glowRadiusFactor: 75.0,
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 150),
          child: TextHighlight(
            text: _recordText,
            words: highlights,
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w400
            ),
          ),
        ),
      )
    );
  }

  void _listen() async {
    if (!_isListening) {
      // 麦克风初始化
      bool available = await _sttUtil.initialize();
      if (available) {
        setState(() {
          _isListening = true;
        });
        // 监听麦克风的内容
        _sttUtil.startListening((res) => {
              setState(() {
                _recordText = res;
                log('监听到的文字：$_recordText');
              })
            });
      }
    } else {
      setState(() {
        _isListening = false;
      });
      // 停止监听
      _sttUtil.stopListening();
    }
  }

  @override
  void dispose() {
    super.dispose();
    // 销毁
    _sttUtil.dispose();
  }
}
