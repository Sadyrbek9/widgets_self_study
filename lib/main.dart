import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _loading;
  late double _progressValue;
  static const oneSec = Duration(seconds: 1);
  @override
  void initState() {
    _loading = false;
    _progressValue = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          title: const Text(
            'My First App',
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: _loading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LinearProgressIndicator(
                        value: _progressValue,
                      ),
                      Text(
                        '${(_progressValue * 100).round()}%',
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  )
                : const Text(
                    'Press button to download',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _loading = !_loading;
              _updateProgress();
            });
          },
          child: const Icon(Icons.cloud_download),
        ),
      ),
    );
  }
  void _updateProgress(){
    Timer.periodic(oneSec, (Timer t) { 
      setState(() {
        _progressValue += 0.3;

        if(_progressValue >= 1.0){
          _loading = false;
          t.cancel();
          _progressValue = 0.0;
        }
      });
    });
  }
}
