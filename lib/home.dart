import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotlas/models/post.dart';
import 'package:spotlas/widgets/post_widget.dart';

import 'change notifiers/post_list_change_notifier.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  late PostListChangeNotifier postListCN;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    postListCN = Provider.of<PostListChangeNotifier>(context);
    return  FutureBuilder<List<Post>?>(
      future: postListCN.fetchPosts(),
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

}
