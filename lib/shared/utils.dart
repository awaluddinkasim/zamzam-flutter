import 'package:flutter/material.dart';

void loading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Dialog(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16.0),
              Text('Loading...'),
            ],
          ),
        ),
      );
    },
  );
}

void alert(BuildContext context, String status, String msg) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(status),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

void redirect(BuildContext context, next) {
  final navigator = Navigator.of(context);

  navigator.pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => next,
    ),
    (route) => false,
  );
}
