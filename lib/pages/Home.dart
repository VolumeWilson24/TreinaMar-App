import 'package:flutter/material.dart';
import 'package:treinamar/pages/About.dart';
import 'package:treinamar/pages/Create.dart';
import 'package:treinamar/pages/Qr_code.dart';
import 'package:treinamar/pages/Training.dart';
import 'package:treinamar/widgets/Item_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeigth = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('TreinaMar'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.lightBlue[100],
              padding: EdgeInsets.all(16),
              height: screenHeigth * .42,
              width: double.infinity,
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  Text(
                    'Olá Francisco',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Image.asset(
                      'assets/user-male.jpg',
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    '50 pontos',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Trilha do Conhecimento',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: Image.asset('assets/trilha.png'),
                ),
                Container(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      ItemList(
                        asset: 'assets/initial.png',
                        progress: 'Concluído',
                        level: 'Iniciante',
                        color: Colors.yellow[600],
                      ),
                      ItemList(
                        asset: 'assets/intermed.png',
                        progress: 'Concluído',
                        level: 'Nível 2',
                        color: Colors.green[200],
                      ),
                      ItemList(
                        asset: 'assets/intermed.png',
                        progress: 'Em Andamento',
                        level: 'Nível 3',
                        color: Colors.green[200],
                      ),
                      ItemList(
                        asset: 'assets/super.png',
                        progress: 'Bloqueado',
                        level: 'Pro',
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: navDrawer(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.crop_free),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => QrCode()));
        },
      ),
    );
  }

  Drawer navDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment
                  .bottomRight, // 10% of the width, so there are ten blinds.
              colors: [
                const Color(0xFF0C154A),
                const Color(0xFF192DA1)
              ], // whitish to gray
            )),
            child: Center(
              child: Text(
                "Treinamar",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.class_),
            title: Text('Meus treinamentos'),
            onTap: () {
              setState(() {
                Navigator.of(context).pop();

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext ctx) => Training(),
                ));
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text('Criar conteúdo'),
            onTap: () {
              Navigator.of(context).pop();

              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext ctx) => Create(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Perfil'),
            onTap: () {
              setState(() {
                Navigator.of(context).pop();
                soonDialog();
              });
            },
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Sobre o App'),
            onTap: () {
              setState(() {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext ctx) => About(),
                ));
              });
            },
          ),
        ],
      ),
    );
  }

  soonDialog() {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Text('Em breve'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
