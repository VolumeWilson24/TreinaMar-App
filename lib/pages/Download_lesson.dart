import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:treinamar/models/Boat.dart';
import 'package:treinamar/models/Lesson.dart';
import 'package:http/http.dart' as http;
import 'package:treinamar/pages/Panorama_view.dart';
import 'package:video_player/video_player.dart';

class DownloadLesson extends StatefulWidget {
  final Boat boat;

  const DownloadLesson({Key key, this.boat}) : super(key: key);

  @override
  _DownloadLessonState createState() => _DownloadLessonState();
}

class _DownloadLessonState extends State<DownloadLesson> {
  VideoPlayerController _controller;
  List<Lesson> listLessons = new List<Lesson>();

  Future fetchLessons() async {
    final response = await http.get(
        'http://http://treinamar.lymtec.com.br:5000/lesson/${widget.boat.sId}');

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
    _controller = VideoPlayerController.network(
        'https://aulas-ws.s3.amazonaws.com/e66b3eacb21c37ebec505d07e8d30e53.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
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
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
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
