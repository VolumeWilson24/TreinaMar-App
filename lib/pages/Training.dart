import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:treinamar/models/Boat.dart';
import 'package:treinamar/pages/Download_lesson.dart';

class Training extends StatefulWidget {
  @override
  _TrainingState createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  List<Boat> listBoat = List<Boat>();

  Future fetchBoats() async {
    final response =
        await http.get('http://treinamar.lymtec.com.br:5000/boats');

    if (response.statusCode == 200) {
      Iterable jsonResponse = convert.jsonDecode(response.body);
      List<Boat> boats = jsonResponse.map((x) => Boat.fromJson(x)).toList();
      setState(() {
        listBoat = boats;
      });
    } else {
      throw Exception('Failed to load boat');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBoats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Treinamentos'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
            itemCount: listBoat.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => DownloadLesson(boat: listBoat[index],)));
                },
                child: (Container(
                  height: 200,
                  margin: EdgeInsets.all(16),
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          listBoat[index].imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 50,
                        child: Text(
                          listBoat[index].name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
              );
            }),
      ),
    );
  }
}
