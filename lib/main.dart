import 'package:dart_http_request/services/notes_service.dart';
import 'package:dart_http_request/views/note_listesi.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


///GetIt Paketi
void setupLocator(){
  //GetIt.I.registerLazySingleton(() => NotesService());
  GetIt.instance.registerLazySingleton(() => NotesService());
  //GetIt.instance<NotesService>();
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Necati Çuhadar',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: NoteListesi(),
    );
  }
}
