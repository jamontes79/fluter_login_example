import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final String displayMessage;

  MessageDisplay({
    Key key,
    @required this.displayMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Center(
                child: SingleChildScrollView(
                  child: Text(
                    this.displayMessage,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
