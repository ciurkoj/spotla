import 'package:flutter/material.dart';
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
    return Center(
      child: FutureBuilder<List<Post>>(
        future: PostListChangeNotifier().fetchPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          List<Widget> children;
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            children = <Widget>[
              ListView.builder(
                controller: ScrollController(),
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return PostWidget(post: snapshot.data![index]);
                },
              )
            ];
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error,
                color: Colors.red,
                size: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(fontSize: 20),
                ),
              )
            ];
          } else {
            children = <Widget>[
              Column(
                children: const [
                  SizedBox(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                    width: 80,
                    height: 80,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      'Retrieving Data',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ];
          }
          return ListView(
            children: children,
          );
        },
      ),
    );
  }
}
