import 'package:flutter/material.dart';

class NoteSilme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Uyarı"),
      content: Text("Silmek istediğine emin misin?"),
      actions: [
        FlatButton(
            onPressed: () => Navigator.pop(context,true), child: Text("Evet")),
        FlatButton(
            onPressed: () => Navigator.pop(context,false),
            child: Text("Hayır")),
      ],
    );
  }
}
