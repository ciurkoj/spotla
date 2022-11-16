import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spotlas/models/post.dart';


class WebRequests{
  static const URL = "https://dev.api.spotlas.com/interview/feed?page=1";

  static Future<List<Post>?> fetchPosts() async {
    final response = await http
        .get(Uri.parse(URL));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body)
          .map<Post>((movie) => Post.fromJson(movie))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load posts');
    }
  }
}