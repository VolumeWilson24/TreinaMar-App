import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treinamar/pages/Home.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Criar conteúdo'),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text(
                'Ajude a capacitar seus colegas e ganhe mais pontos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Adicione um título'),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 52,
                child: FlatButton(
                  child: Text('Adicione seu material'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(width: 2),
                  ),
                  onPressed: getImage,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 200,
                child: _image == null
                    ? Text('Nehum arquivo selecionado')
                    : Image.file(_image),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: RaisedButton(
                  color: Color(0xFF020F59),
                  child: Text(
                    'Enviar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => HomePage()));
                  },
                ),
              )
            ],
          ),
        ));
  }
}
