import 'package:json_annotation/json_annotation.dart';

part 'note_for_listing.g.dart';

@JsonSerializable()
class NoteForListing {
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;

  //Constructer
  NoteForListing(
      {this.noteID,
      this.noteTitle,
      this.createDateTime,
      this.latestEditDateTime});

  //Json formatini Map'e donusturme
  factory NoteForListing.fromJson(Map<String, dynamic> json) => _$NoteForListingFromJson(json);

      // NoteForListing(
      //   noteID: json["noteID"],
      //   noteTitle: json["noteTitle"],
      //   createDateTime: DateTime.parse(json["createDateTime"]),
      //   latestEditDateTime: json["latestEditDateTime"] != null
      //       ? DateTime.parse(json['latestEditDateTime'])
      //       : null,
      // );
}
