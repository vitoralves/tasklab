import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    print(_mediaQuery.size.width);
    final double _iconSize =
        _mediaQuery.size.width > 500 && _mediaQuery.size.height > 500
            ? 300
            : 100;
    final double _fontSize =
        _mediaQuery.size.width > 500 && _mediaQuery.size.height > 500 ? 50 : 30;

    return Center(
        child: Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.library_books,
            size: _iconSize,
          ),
          Expanded(
            child: Text(
              'You don\'t have any note, use the button add (+) to start.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: _fontSize,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
