// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      response: (json['response'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
    };

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      caption: json['caption'] == null
          ? null
          : Caption.fromJson(json['caption'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      spot: json['spot'] == null
          ? null
          : Spot.fromJson(json['spot'] as Map<String, dynamic>),
      relevantComments: json['relevant_comments'] as int?,
      numberOfComments: json['number_of_comments'] as int?,
      likedBy: (json['liked_by'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : Author.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberOfLikes: json['number_of_likes'] as int?,
      tags: json['tags'] as int?,
      url: json['url'] as String?,
      id: json['id'] as String?,
      media: (json['media'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : Media.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'caption': instance.caption,
      'media': instance.media,
      'created_at': instance.createdAt,
      'author': instance.author,
      'spot': instance.spot,
      'relevant_comments': instance.relevantComments,
      'number_of_comments': instance.numberOfComments,
      'liked_by': instance.likedBy,
      'number_of_likes': instance.numberOfLikes,
      'tags': instance.tags,
      'url': instance.url,
    };

Spot _$SpotFromJson(Map<String, dynamic> json) => Spot(
      id: json['id'] as String?,
      name: json['name'] as String?,
      types: (json['types'] as List<dynamic>?)
          ?.map((e) => PlaceType.fromJson(e as Map<String, dynamic>))
          .toList(),
      logo: json['logo'] == null
          ? null
          : Media.fromJson(json['logo'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      isSaved: json['is_saved'] as bool?,
    );

Map<String, dynamic> _$SpotToJson(Spot instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'types': instance.types,
      'logo': instance.logo,
      'location': instance.location,
      'is_saved': instance.isSaved,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      display: json['display'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'display': instance.display,
    };

PlaceType _$PlaceTypeFromJson(Map<String, dynamic> json) => PlaceType(
      id: json['id'] as int?,
      name: json['name'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$PlaceTypeToJson(PlaceType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      id: json['id'] as String?,
      username: json['username'] as String?,
      photoUrl: json['photo_url'] as String?,
      fullName: json['full_name'] as String?,
      isPrivate: json['isPrivate'] as bool?,
      isVerified: json['isVerified'] as bool?,
      followStatus: json['follow_status'] as String?,
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'photo_url': instance.photoUrl,
      'full_name': instance.fullName,
      'isPrivate': instance.isPrivate,
      'isVerified': instance.isVerified,
      'follow_status': instance.followStatus,
    };

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
      url: json['url'] as String?,
      blurHash: json['blur_hash'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'url': instance.url,
      'blur_hash': instance.blurHash,
      'type': instance.type,
    };

Caption _$CaptionFromJson(Map<String, dynamic> json) => Caption(
      text: json['text'] as String?,
    );

Map<String, dynamic> _$CaptionToJson(Caption instance) => <String, dynamic>{
      'text': instance.text,
    };
