import 'package:flutter/material.dart';
import 'package:spotlas/models/post.dart';
import 'package:spotlas/post_widget.dart';
import 'package:spotlas/web_requests.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  List<Post>? posts;

  @override
  void initState() {
    super.initState();
    fetchPosts().then((value) => posts = value);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<List<Post>?>(
      future: fetchPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return PostWidget(post: snapshot.data![index]);

            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Future<List<Post>?> fetchPosts() async {
    return await WebRequests.fetchPosts();
  }
}
