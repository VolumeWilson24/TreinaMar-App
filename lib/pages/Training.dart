import 'dart:convert' as convert;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treinamar/models/Boat.dart';
import 'package:treinamar/pages/Download_lesson.dart';

class Training extends StatefulWidget {
  @override
  _TrainingState createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  List<Boat> listBoat = List<Boat>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _downloading = false;

  Future<bool> getConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future fetchBoats() async {
    final SharedPreferences prefs = await _prefs;

    if(await getConnection()) {
      _downloading = true;
      final response =
          await http.get('http://treinamar.lymtec.com.br:5000/boats');

      if (response.statusCode == 200) {
        await prefs
            .setString('boats', response.body)
            .then((value) => {
              getLocalBoats(),
              _downloading = false,
            }
            );
      } else {
        throw Exception('Failed to load boat');
      }
    }else {
      print('sem internet');
    }
  }

  Future getLocalBoats() async {
    final SharedPreferences prefs = await _prefs;
    String boats = prefs.getString('boats') ?? '[]';
    Iterable jsonBoats = convert.jsonDecode(boats);
    List<Boat> allBoats = jsonBoats.map((x) => Boat.fromJson(x)).toList();
    setState(() {
      listBoat = allBoats;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocalBoats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEF6FF),
      appBar: AppBar(
        title: Text('Meus Treinamentos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: fetchBoats,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: listBoat.length < 1
            ? Center(child: _downloading? CircularProgressIndicator : Text('Sem aulas baixadas'))
            : ListView.builder(
                itemCount: listBoat.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => DownloadLesson(
                                boat: listBoat[index],
                              )));
                    },
                    child: (Container(
                      height: 200,
                      margin: EdgeInsets.all(16),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: listBoat[index].imageUrl,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
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
