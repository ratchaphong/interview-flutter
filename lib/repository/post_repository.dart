import 'package:hello_flutter/models/post_db/post.dart';
import 'package:hello_flutter/repository/the_post_db_provider.dart';

class PostRepository {
  final ThePostDbProvider provider;
  List<Post> rawDatas = [];
  Post? rawData;

  PostRepository(this.provider);

  Future<List<Post>> getPosts() async {
    rawDatas = await provider.getPosts();
    return rawDatas;
  }

  Future<Post?> getPost(int? id) async {
    rawData = await provider.getPost(id);
    return rawData;
  }
}
