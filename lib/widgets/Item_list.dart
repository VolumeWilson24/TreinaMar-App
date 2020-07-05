import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  final String asset;
  final String progress;
  final String level;
  final Color color;

  const ItemList({Key key, this.asset, this.progress, this.level, this.color}) : super(key: key);

  Color progressColor() {
    switch(progress) {
      case 'Concluído':
        return Colors.green[400];
      case 'Em Andamento':
        return Colors.yellow[200];
      case 'Bloqueado':
        return Colors.black38;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[
          Image.asset(
            asset,
            height: 100,
            color: progress == 'Bloqueado'? Colors.grey[600]: null,
          ),
          Text(level,
            style: TextStyle(
              color: Colors.black38,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(progress,
            style: TextStyle(
              color: progressColor(),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
