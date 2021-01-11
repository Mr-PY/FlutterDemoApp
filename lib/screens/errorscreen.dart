import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("🙈",
                    style: TextStyle(
                      fontSize: 28.0,
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Something went wrong',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                    horizontal: 28.0,
                    vertical: 16.0,
                  )),
                  icon: Icon(Icons.home),
                  label: Text('Go Home'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
