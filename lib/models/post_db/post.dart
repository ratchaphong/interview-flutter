import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class Post {
  final int? id;
  final String? title;
  final String? body;
  final int? userId;
  final List<String>? tags;
  final int? reactions;

  const Post({
    this.id,
    this.title,
    this.body,
    this.userId,
    this.tags,
    this.reactions,
  });

  @override
  String toString() {
    return 'Post(id: $id, title: $title, body: $body, userId: $userId, tags: $tags, reactions: $reactions)';
  }

  factory Post.fromJsonString(Map<String, dynamic> data) => Post(
        id: data['id'] as int?,
        title: data['title'] as String?,
        body: data['body'] as String?,
        userId: data['userId'] as int?,
        tags: data['tags'] as List<String>?,
        reactions: data['reactions'] as int?,
      );

  Map<String, dynamic> toJsonString() => {
        'id': id,
        'title': title,
        'body': body,
        'userId': userId,
        'tags': tags,
        'reactions': reactions,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Post].
  factory Post.fromJson(String data) {
    return Post.fromJsonString(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Post] to a JSON string.
  String toJson() => json.encode(toJsonString());

  Post copyWith({
    int? id,
    String? title,
    String? body,
    int? userId,
    List<String>? tags,
    int? reactions,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      userId: userId ?? this.userId,
      tags: tags ?? this.tags,
      reactions: reactions ?? this.reactions,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Post) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJsonString(), toJsonString());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      body.hashCode ^
      userId.hashCode ^
      tags.hashCode ^
      reactions.hashCode;
}
