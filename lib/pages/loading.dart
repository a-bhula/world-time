import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void getTime() async {
    print('Starting API call...');
    final startTime = DateTime.now();
    
    try {
      print('Making HTTP request...');
      Response response = await get(Uri.parse('http://worldclockapi.com/api/json/utc/now'));
      final duration = DateTime.now().difference(startTime);
      
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        print('API loaded successfully in ${duration.inMilliseconds}ms');
        Map data = jsonDecode(response.body);
        print('Received time: ${data['currentDateTime']}');
        print('UTC Offset: ${data['utcOffset']}');
      } else {
        print('API returned status ${response.statusCode} after ${duration.inMilliseconds}ms');
      }
    } catch (e) {
      final duration = DateTime.now().difference(startTime);
      print('API failed after ${duration.inMilliseconds}ms - Error: $e');
    }
    
    // Navigate to home page
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void initState() {
    super.initState();
    print('Loading page initialized');
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('loading screen'),
      ),
    );
  }
}

 