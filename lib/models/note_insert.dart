import 'package:json_annotation/json_annotation.dart';

part 'note_insert.g.dart';

@JsonSerializable()
class NoteManipulation {
  String noteTitle;
  String noteContent;

  NoteManipulation({this.noteTitle, this.noteContent});

  factory NoteManipulation.fromJson(Map<String, dynamic> json) =>
      NoteManipulation(
        noteTitle: json["noteTitle"],
        noteContent: json["noteContent"],
      );

  Map<String, dynamic> toJson() =>  _$NoteManipulationToJson(this);
      // {
      //   "noteTitle": noteTitle == null ? null : noteTitle,
      //   "noteContent": noteContent == null ? null : noteContent,
      // };
}
