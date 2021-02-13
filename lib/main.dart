import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:student/Students.dart';
import 'package:student/assets/students.json';
import 'package:student/list.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: new ThemeData(
      primaryColor: const Color(0xFF02BB9F),
      primaryColorDark: const Color(0xFF167F67),
      accentColor: const Color(0xFF167F67),
    ),
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  List data;



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Load local JSON file",
            style: new TextStyle(color: Colors.white),),
        ),
        body: new Container(
            child: new Center(
              child: new FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/students.json'),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('Press button to start.');
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return new Center(child: new CircularProgressIndicator());
                    case ConnectionState.done:
                      if (snapshot.hasError){
                        return Text('Error: ${snapshot.error}');
                      }else{
                        List<Students> students =
                        parseJosn(snapshot.data.toString());
                        return !students.isEmpty
                            ? new CountyList(students:students)
                            : new Text("file is empty");
                      }

                  }
                  return null; // unreachable
                },
              ),
            )));
  }

  List<Students> parseJosn(String response) {
    if(response==null){
      return [];
    }
    final parsed =
    json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Students>((json) => new Students.fromJson(json)).toList();
  }
}