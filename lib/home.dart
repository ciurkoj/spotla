import 'dart:async';
import 'package:flutter/material.dart';
import 'package:spotlas/change%20notifiers/post_list_change_notifier.dart';
import 'package:spotlas/models/post.dart';
import 'package:spotlas/widgets/post_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  showSnack() {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New content loaded'),
      ),
    );
  }

  Future<void> _handleRefresh() async {;
  PostListChangeNotifier().fetchPosts().then((res) async {
      showSnack();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(title: const Text('Spotlas'), actions: <Widget>[
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: _handleRefresh,
          )
        ]),
        body: FutureBuilder<List<Post>?>(
            future: PostListChangeNotifier().fetchPosts(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<Widget> children;
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                children = <Widget>[
                  ListView.builder(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      Post post = snapshot.data![index];
                      // adding a dummy parameter to reload the image
                      post.media!.forEach((element) => element!.url =
                          "${element.url}?r=${DateTime.now().toString()}");
                      return PostWidget(post: post);
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
              return RefreshIndicator(
                displacement: 250,
                strokeWidth: 3,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: _handleRefresh,
                child: ListView(children: children)
              );
            }));
  }
}
