import 'package:flutter/material.dart';

class TableRowDetails extends StatelessWidget {
  TableRowDetails({required this.title, required this.value});

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(16),
            color: const Color.fromARGB(255, 36, 36, 36),
            child: Text(
              addNewLineCharacter(value),
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(16),
            color: const Color.fromARGB(255, 35, 35, 35),
            child: Text(
              value,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ),
      ],
    );
  }

  String addNewLineCharacter(String result) {
    if (result.length <= 23 && result.allMatches(' ').length <= 2) {
      return title;
    } else {
      return title + '\n';
    }
  }
}