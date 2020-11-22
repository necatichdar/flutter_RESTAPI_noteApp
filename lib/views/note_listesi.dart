import 'package:dart_http_request/models/api_response.dart';
import 'package:dart_http_request/models/note_for_listing.dart';
import 'package:dart_http_request/services/notes_service.dart';
import 'package:dart_http_request/views/note_duzenleme.dart';
import 'package:dart_http_request/views/note_silme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NoteListesi extends StatefulWidget {
  @override
  _NoteListesiState createState() => _NoteListesiState();
}

class _NoteListesiState extends State<NoteListesi> {
  NotesService get service => GetIt.instance<NotesService>();
  APIResponse<List<NoteForListing>> _apiResponse;
  bool _isLoading = false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNoteList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP Not Uygulaması"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NoteDuzenleme()))
              .then((value) => _fetchNotes());
        },
        child: Icon(Icons.add),
      ),
      body: Builder(
        builder: (context) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (_apiResponse?.error) {
            return Center(
              child: Text(_apiResponse.errorMessage),
            );
          }

          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.red,
              height: 1,
            ),
            itemCount: _apiResponse.data.length,
            itemBuilder: (context, index) {
              var note = _apiResponse.data[index];
              return Dismissible(
                key: ValueKey(note.noteID),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {},
                //? Onaylamak
                background: Container(
                  padding: EdgeInsets.only(left: 16),
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.delete),
                ),
                confirmDismiss: (direction) async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) => NoteSilme(),
                  );
                  if (result) {
                    final deleteResult = await service.deleteNote(note.noteID);
                    var message;
                    if (deleteResult != null && deleteResult.data == true) {
                      message = "Not başarıyla silindi.";
                    } else {
                      message = deleteResult?.errorMessage ?? "Hata oluştu";
                    }
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Bitti"),
                        content: Text(message),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                _fetchNotes();
                                Navigator.pop(context);
                              },
                              child: Text("Tamam"))
                        ],
                      ),
                    );
                    return deleteResult?.data ?? false;
                  }

                  print(result);
                  return result;
                },
                child: ListTile(
                  title: Text(
                    note.noteTitle ?? "Boş",
                  ),
                  subtitle: Text(
                      "Last Edited on ${formatDateTime(note.latestEditDateTime ?? note.createDateTime)}"),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NoteDuzenleme(
                                noteID: note.noteID,
                              ))).then((data) => _fetchNotes()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
