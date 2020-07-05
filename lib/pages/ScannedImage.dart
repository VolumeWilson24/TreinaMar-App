import 'package:flutter/material.dart';
import 'package:treinamar/pages/Home.dart';

class ScannedImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: <Widget>[
            Image.asset('assets/engine.jpg'),
            SizedBox(
              height: 16,
            ),
            Text(
              'Motor',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 24,
            ),
            Text('explicação dos cuidados com o motor'), 
            Spacer(),
            FlatButton(
              child: Text('Sair'),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2)
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
