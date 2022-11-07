import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spotlas/models/post.dart';
import 'package:intl/intl.dart';

class PostWidget extends StatefulWidget {
  final Post? post;
  const PostWidget({Key? key, this.post}) : super(key: key);

  @override
  _PostWidgetState createState() {
    return _PostWidgetState();
  }
}

class _PostWidgetState extends State<PostWidget> with SingleTickerProviderStateMixin  {
  bool mybool = true;
  Size? _size;
  TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: widget.post!.media!.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      // boundary needed for web
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
              height: _size?.height ?? 0,
              child: PageView.builder(
                onPageChanged: (int page){
                  controller?.index = page;
                },
                controller: PageController(viewportFraction: 1.15),
                  itemCount: widget.post!.media!.length,
                  pageSnapping: true,
                  padEnds: false,
                  itemBuilder: (context,pagePosition){
                    Image image = Image.network(widget.post!.media![pagePosition]!.url!);
                    _calculateImageDimension().then((size) {
                      setState(() {
                        _size= size;
                      });
                    }); // 487.0,696.0
                    return image;
                  }),
            ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black38,
                      Colors.black26,
                      Colors.black26,
                      Colors.transparent
                    ],
                    begin: Alignment.topCenter,
                    end: AlignmentDirectional.bottomCenter
                  )
                ),
                // color: Colors.black12,
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 16,
                ).copyWith(right: 0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.pinkAccent,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            widget.post!.author!.photoUrl!
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.post!.author!.username!,
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.headline6!.fontSize,
                                color:Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.post!.author!.fullName!,
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
                                color:Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          useRootNavigator: false,
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: ListView(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16),
                                  shrinkWrap: true,
                                  children: [
                                    'Delete',
                                  ]
                                      .map(
                                        (e) => InkWell(
                                        child: Container(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12,
                                              horizontal: 16),
                                          child: Text(e),
                                        ),
                                        ),
                                  )
                                      .toList()),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                    child: TabPageSelector(controller: controller,)),
              ),
            )
            ],
          ),
          // LIKE, COMMENT SECTION OF THE POST
          Row(
            children: <Widget>[
              Container(color: Colors.white),
              const IconButton(
                icon: Icon(
                  Icons.comment_outlined,
                ),
                onPressed: null
              ),
              IconButton(
                  icon: const Icon(
                    Icons.send,
                  ),
                  onPressed: () {}),
              Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                        icon: const Icon(Icons.bookmark_border), onPressed: () {}),
                  ))
            ],
          ),
          //DESCRIPTION AND NUMBER OF COMMENTS
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(
                      widget.post!.numberOfLikes!.toString(),
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.post!.author!.username!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: widget.post!.caption!.text!,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    child: const Text(
                      'View all  comments',
                      style:  TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                  ),
                  onTap: null,
                ),
                Container(
                  child: Text(
                    DateFormat.yMd().format(DateTime.parse(widget.post!.createdAt!)).toString(),
                    style: TextStyle(
                      color: Theme.of(context).textTheme.caption!.color,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<Size> _calculateImageDimension() {
    Completer<Size> completer = Completer();
    Image image = Image.network("https://i.stack.imgur.com/lkd0a.png");
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
            (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }
}