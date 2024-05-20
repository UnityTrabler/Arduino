import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LED Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLedOn = false;

  void _toggleLed() async {
    // 아두이노 서버의 IP 주소와 포트를 여기에 입력하세요.
    final String arduinoIp = '172.30.1.78';
    final int arduinoPort = 80;

    try {
      final response =
          await http.get(Uri.parse('http://$arduinoIp:$arduinoPort/toggle'));
      if (response.statusCode == 200) {
        setState(() {
          isLedOn = !isLedOn;
        });
      }
    } catch (e) {
      print('에러: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LED Controller'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _toggleLed,
          child: Text(isLedOn ? 'LED 끄기' : 'LED 켜기'),
        ),
      ),
    );
  }
}
