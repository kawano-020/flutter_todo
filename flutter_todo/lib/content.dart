import 'package:flutter/material.dart';
import 'package:flutter_todo/main.dart';

class ContentPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
        backgroundColor: Colors.blue[700],
      ),
      body: Center(
        child: Text(args.content,
          style: TextStyle(fontSize: 30)
        )
      ),
    );
  }
}
