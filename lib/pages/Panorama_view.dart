import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

class PanoramaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vista da sala de Máquinas'),
      ),
          body: Container(
        child: Panorama(
          animSpeed: 2.0,
          child: Image.asset('assets/engine_room.jpeg'), 
        )
      ),
    );
  }
}