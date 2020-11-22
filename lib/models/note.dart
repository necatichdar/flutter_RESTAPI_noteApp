import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  String noteID;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime latestEditDateTime;

  //Constructer
  Note(
      {this.noteID,
      this.noteTitle,
      this.noteContent,
      this.createDateTime,
      this.latestEditDateTime});

  //Json formatini Map'e donusturme
  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
// Note(
//   noteID: json["noteID"],
//   noteTitle: json["noteTitle"],
//   noteContent: json["noteContent"],
//   createDateTime: DateTime.parse(json["createDateTime"]),
//   latestEditDateTime: json["latestEditDateTime"] != null
//       ? DateTime.parse(json['latestEditDateTime'])
//       : null,
// );
}
