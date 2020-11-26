import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'content.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      routes: {
        "/": (context) => MyHomePage(),
        "/content": (context) => ContentPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Map data;
  List useData;
  String initUrl = "http://192.168.3.50:5000/";

  Future getData(url) async{
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    setState(() {
      useData = data["list"];
    });
  }

  void initState() {
    super.initState();
    getData(initUrl);
  }

  void swichSearch(word) {
    getData(initUrl+"search/$word");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        title: Text("ローカルのAPIを叩いてみるよ。"),
        backgroundColor: Colors.blue[700],
      ),
      body: ListView.builder(
        itemCount: useData == null ? 0 : useData.length,
        itemBuilder: (BuildContext context, int index) {
          return ListItem(useData[index]);
        },
      ),
    );
  }

  Widget ListItem(item) {
    String date = item["date"].toString();
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: Text("${item["subject"]}",
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Text(
            "${date.substring(0,2)}月${date.substring(2,4)}日"
            "${date.substring(4,6)}:${date.substring(6,8)}"
            ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.pushNamed(
              context,
              "/content",
              arguments: ScreenArguments(item["subject"], item["content"])
            );
          },
        ),
      ),
    );
  }
}

class ScreenArguments {
  final title;
  final content;
  ScreenArguments(this.title, this.content);
}
