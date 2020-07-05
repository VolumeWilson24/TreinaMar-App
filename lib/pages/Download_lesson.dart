import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:treinamar/models/Boat.dart';
import 'package:treinamar/models/Lesson.dart';
import 'package:http/http.dart' as http;
import 'package:treinamar/pages/Panorama_view.dart';

class DownloadLesson extends StatefulWidget {
  final Boat boat;

  const DownloadLesson({Key key, this.boat}) : super(key: key);

  @override
  _DownloadLessonState createState() => _DownloadLessonState();
}

class _DownloadLessonState extends State<DownloadLesson> {
  List<Lesson> listLessons = new List<Lesson>();

  Future fetchLessons() async {
    final response =
        await http.get('http://http://treinamar.lymtec.com.br:5000/lesson/${widget.boat.sId}');

    if (response.statusCode == 200) {
      Iterable jsonResponse = convert.jsonDecode(response.body);
      List<Lesson> lessons =
          jsonResponse.map((x) => Lesson.fromJson(x)).toList();

      setState(() {
        listLessons = lessons;
      });
    } else {
      throw Exception('Failed to load lesson');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchLessons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEF6FF),
      appBar: AppBar(
        title: Text(widget.boat.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.panorama),
            onPressed: () {
              Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => PanoramaView()));
            },
          )
        ],
      ),
      body: Center(
        child: listLessons.length > 0
            ? downloadButton()
            : Text('Nenhuma aula disponível'),
      ),
    );
  }

  Widget downloadButton() {
    String plural = listLessons.length == 1 ? 'aula' : 'aulas';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Está embarcação tem ${listLessons.length} $plural disponíveis'),
        SizedBox(
          height: 16,
        ),
        FlatButton(
          child: Text(
            'Baixar aulas',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.blueGrey,
          onPressed: () {},
        )
      ],
    );
  }
}
