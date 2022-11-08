import 'package:flutter/material.dart';
import 'package:spotlas/web_requests.dart';

import '../models/post.dart';

class PostListChangeNotifier extends ChangeNotifier{
  List<Post> posts = [];
  List<Post> favPosts = [];
  List<Post> savedPosts = [];


  Future<List<Post>> fetchPosts() async {
    posts = (await WebRequests.fetchPosts())!;
    notifyListeners();
    return posts;
  }


  setFavourite(Post post) {
    favPosts.add(post);
    notifyListeners();
  }
  setSaved(Post post) {
    savedPosts.add(post);
    notifyListeners();
  }

  removeFavourite(Post post) {
    favPosts.removeWhere((element) => element.id == post.id);
    notifyListeners();
  }
  removeSaved(Post post) {
    savedPosts.removeWhere((element) => element.id == post.id);
    notifyListeners();
  }
}