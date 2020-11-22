import 'dart:convert';

import 'package:dart_http_request/models/api_response.dart';
import 'package:dart_http_request/models/note.dart';
import 'package:dart_http_request/models/note_for_listing.dart';
import 'package:dart_http_request/models/note_insert.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const API = "https://tq-notes-api-jkrgrdggbq-el.a.run.app/";
  static const headers = {
    'apiKey': '118ad2fe-e7ba-4167-a5c3-cbdcbfed504a',
    'Content-Type': 'application/json'
  };

  Future<APIResponse<List<NoteForListing>>> getNoteList() {
    return http.get(API + "/notes", headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          final note = NoteForListing.fromJson(item);
          notes.add(note);
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(
          error: true, errorMessage: 'Bir hata oluştu');
    }).catchError(
      (_) => APIResponse<List<NoteForListing>>(
          error: true, errorMessage: 'Bir hata oluştu'),
    );
  }

  Future<APIResponse<Note>> getNote(String noteID) {
    return http.get(API + "/notes/" + noteID, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        return APIResponse<Note>(data: Note.fromJson(jsonData));
      }
      return APIResponse<Note>(error: true, errorMessage: 'Bir hata oluştu');
    }).catchError(
      (_) => APIResponse<Note>(error: true, errorMessage: 'Bir hata oluştu'),
    );
  }

  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http
        .post(API + "/notes",
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Bir hata oluştu');
    }).catchError(
      (_) => APIResponse<bool>(error: true, errorMessage: 'Bir hata oluştu'),
    );
  }

  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http
        .put(API + "/notes/" + noteID,
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Bir hata oluştu');
    }).catchError(
      (_) => APIResponse<bool>(error: true, errorMessage: 'Bir hata oluştu'),
    );
  }
  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http
        .delete(API + "/notes/" + noteID,
            headers: headers)
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'Bir hata oluştu');
    }).catchError(
      (_) => APIResponse<bool>(error: true, errorMessage: 'Bir hata oluştu'),
    );
  }
}
