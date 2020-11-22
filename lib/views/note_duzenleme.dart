import 'package:dart_http_request/models/note.dart';
import 'package:dart_http_request/models/note_insert.dart';
import 'package:dart_http_request/services/notes_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NoteDuzenleme extends StatefulWidget {
  final String noteID;

  const NoteDuzenleme({Key key, this.noteID}) : super(key: key);

  @override
  _NoteDuzenlemeState createState() => _NoteDuzenlemeState();
}

class _NoteDuzenlemeState extends State<NoteDuzenleme> {
  bool get isEditing => widget.noteID != null;

  NotesService get notesService => GetIt.instance<NotesService>();

  String errorMessage;
  Note note;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      notesService.getNote(widget.noteID).then((response) {
        setState(() {
          _isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ?? "Hata oluştu";
        }
        note = response.data;
        _titleController.text = note.noteTitle;
        _contentController.text = note.noteContent;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Not Düzenleme" : "Not Oluştur"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.all(12),
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(hintText: "Not Başlığı"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _contentController,
                  decoration: InputDecoration(hintText: "Not İçeriği"),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  child: Text(
                    "Ekle",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    if (isEditing) {
                      // Apiyi Guncelle
                      setState(() {
                        _isLoading = true;
                      });
                      final note = NoteManipulation(
                        noteTitle: _titleController.text,
                        noteContent: _contentController.text,
                      );
                      final result = await notesService.updateNote(widget.noteID, note);

                      setState(() {
                        _isLoading = false;
                      });

                      final title = 'Bitti';
                      final text = result.error
                          ? result.errorMessage ?? "Hata"
                          : "Not Güncellendi";

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(title),
                          content: Text(text),
                          actions: [
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Tamam"))
                          ],
                        ),
                      ).then((data) {
                        if (result.data) {
                          Navigator.pop(context);
                        }
                      });

                    } else {
                      // Apiye Ekle
                      setState(() {
                        _isLoading = true;
                      });
                      final note = NoteManipulation(
                        noteTitle: _titleController.text,
                        noteContent: _contentController.text,
                      );
                      final result = await notesService.createNote(note);

                      setState(() {
                        _isLoading = false;
                      });

                      final title = 'Bitti';
                      final text = result.error
                          ? result.errorMessage ?? "Hata"
                          : "Not Oluşturuldu";

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(title),
                          content: Text(text),
                          actions: [
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Tamam"))
                          ],
                        ),
                      ).then((data) {
                        if (result.data) {
                          Navigator.pop(context);
                        }
                      });
                    }
                  },
                ),
              ],
            ),
    );
  }
}
