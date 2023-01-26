import 'package:flutter/foundation.dart';
import 'package:hello_flutter/models/post_db/post.dart';
import 'package:hello_flutter/models/post_db/post_db.dart';
import 'package:http/http.dart' as http;

class ThePostDbProvider {
  Future<List<Post>> getPosts() async {
    try {
      var url = Uri.https(
        'dummyjson.com',
        '/posts',
      );
      var r = await http.get(url);
      if (r.statusCode != 200) {
        if (kDebugMode) {
          print("Error");
        }
      }
      var posts = PostDb.fromJson(r.body).posts;
      if (kDebugMode) {
        print(posts);
      }
      if (posts == null) {
        throw Exception('no posts found');
      }
      return posts;
    } catch (e) {
      if (kDebugMode) {
        print('kDebugMode');
        print(e);
      }
      throw Exception(e.toString());
    }
  }
}
