import 'package:json_annotation/json_annotation.dart';
part "post.g.dart";

@JsonSerializable()
class ApiResponse{
  final List<Post>? response;

  ApiResponse({this.response});

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);
}

@JsonSerializable()
class Post{

  final String? id;
  final Caption? caption;
  final List<Media?>? media;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  final Author? author;
  final Spot? spot;
  @JsonKey(name: 'relevant_comments')
  final int? relevantComments;
  @JsonKey(name: 'number_of_comments')
  final int? numberOfComments;
  @JsonKey(name: 'liked_by')
  final List<Author?>? likedBy;
  @JsonKey(name: 'number_of_likes')
  final int? numberOfLikes;
  final int? tags;
  final String? url;

  const Post(
  {
    this.caption,
    this.createdAt,
    this.author,
    this.spot,
    this.relevantComments,
    this.numberOfComments,
    this.likedBy,
    this.numberOfLikes,
    this.tags,
    this.url,
    this.id,
    this.media,
  });
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

}

@JsonSerializable()
class Spot {
  final String? id;
  final String? name;
  final List<PlaceType>? types;
  final Media? logo;
  final Location? location;
  @JsonKey(name: 'is_saved')
  final bool? isSaved;

  const Spot({
    this.id,
    this.name,
    this.types,
    this.logo,
    this.location,
    this.isSaved
  });
  factory Spot.fromJson(Map<String, dynamic> json) => _$SpotFromJson(json);

}
@JsonSerializable()
class Location {
  final double? latitude;
  final double? longitude;
  final String? display;

  Location({
    this.latitude,
    this.longitude,
    this.display
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
}

@JsonSerializable()
class PlaceType {
  final int? id;
  final String? name;
  final String? url;

  PlaceType({
    this.id,
    this.name,
    this.url
  });

  factory PlaceType.fromJson(Map<String, dynamic> json) => _$PlaceTypeFromJson(json);
}

@JsonSerializable()
class Author {
  final String? id;
  final String? username;
  @JsonKey(name: 'photo_url')
  final String? photoUrl;
  @JsonKey(name: 'full_name')
  final String? fullName;
  final bool? isPrivate;
  final bool? isVerified;
  @JsonKey(name: 'follow_status')
  final String? followStatus;

  const Author({
    this.id,
    this.username,
    this.photoUrl,
    this.fullName,
    this.isPrivate,
    this.isVerified,
    this.followStatus
  });
  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

}

@JsonSerializable()
class Media {
  final String? url;
  @JsonKey(name: 'blur_hash')
  final String? blurHash;
  final String? type;
  const Media({
    this.url,
    this.blurHash,
    this.type,
});
  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

}

@JsonSerializable()
class Caption {
  final String? text;
  const Caption({
    this.text
});
  factory Caption.fromJson(Map<String, dynamic> json) => _$CaptionFromJson(json);

}