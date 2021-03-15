import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  final int id;
  final String title;
  final String thumbnailUrl;
  final String url;

  Photo({this.id, this.title, this.thumbnailUrl, this.url});

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);

/*  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as int,
      title: json['title'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      url: json['url'] as String,
    );
  }*/

// Map<String, dynamic> toJson() => {
//       'id': this.id,
//       'title': this.title,
//       'thumbnailUrl': this.thumbnailUrl,
//       'url': this.url
//     };
}
