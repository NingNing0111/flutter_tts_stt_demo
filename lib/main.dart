import 'package:flutter/material.dart';
import 'package:tts_stt_demo/stt.dart';
import 'package:tts_stt_demo/tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),//
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.accessibility),label: "TTS"),
    const BottomNavigationBarItem(icon: Icon(Icons.accessible),label: "STT")
  ];
  int _currIndex = 0;
  final List<Widget> _barItemPage = [
    const TTSPage(),
    const STTPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TTS And STT Demo"),
        centerTitle: true,
      ),
      body: Center(
        child: _barItemPage[_currIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        onTap: changeNav,
        currentIndex: _currIndex,
      ),
    );

  }
  void changeNav(value){
    setState(() {
      _currIndex = value;
    });
  }

}