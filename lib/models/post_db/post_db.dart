import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'post.dart';

@immutable
class PostDb {
  final List<Post>? posts;
  final int? total;
  final int? skip;
  final int? limit;

  const PostDb({this.posts, this.total, this.skip, this.limit});

  @override
  String toString() {
    return 'PostDb(posts: $posts, total: $total, skip: $skip, limit: $limit)';
  }

  factory PostDb.fromJsonString(Map<String, dynamic> data) => PostDb(
        posts: (data['posts'] as List<dynamic>?)
            ?.map((e) => Post.fromJsonString(e as Map<String, dynamic>))
            .toList(),
        total: data['total'] as int?,
        skip: data['skip'] as int?,
        limit: data['limit'] as int?,
      );

  Map<String, dynamic> toJsonString() => {
        'posts': posts?.map((e) => e.toJsonString()).toList(),
        'total': total,
        'skip': skip,
        'limit': limit,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PostDb].
  factory PostDb.fromJson(String data) {
    return PostDb.fromJsonString(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PostDb] to a JSON string.
  String toJson() => json.encode(toJsonString());

  PostDb copyWith({
    List<Post>? posts,
    int? total,
    int? skip,
    int? limit,
  }) {
    return PostDb(
      posts: posts ?? this.posts,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PostDb) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJsonString(), toJsonString());
  }

  @override
  int get hashCode =>
      posts.hashCode ^ total.hashCode ^ skip.hashCode ^ limit.hashCode;
}
