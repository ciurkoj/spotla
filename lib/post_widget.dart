import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spotlas/models/post.dart';

class PostWidget extends StatefulWidget {
  final Post? post;

  const PostWidget({Key? key, this.post}) : super(key: key);

  @override
  _PostWidgetState createState() {
    return _PostWidgetState();
  }
}

class _PostWidgetState extends State<PostWidget>
    with SingleTickerProviderStateMixin {
  Size? _size;
  TabController? controller;
  bool saved = false;
  bool favourite = false;
  bool descTextShowFlag = false;
  bool showAll = true;
  int length = 40;
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
        border: Border.all(color: Colors.black26),
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
                    onPageChanged: (int page) {
                      controller?.index = page;
                    },
                    controller: PageController(viewportFraction: 1.15),
                    itemCount: widget.post!.media!.length,
                    pageSnapping: true,
                    padEnds: false,
                    itemBuilder: (context, pagePosition) {
                      Image image = Image.network(
                          widget.post!.media![pagePosition]!.url!);
                      _calculateImageDimension().then((size) {
                        if (mounted) {
                          setState(() {
                            _size = size;
                          });
                        }
                      });
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
                        end: AlignmentDirectional.bottomCenter)),
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
                        backgroundImage:
                            NetworkImage(widget.post!.author!.photoUrl!),
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
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .fontSize,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.post!.author!.fullName!,
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .fontSize,
                                color: Colors.white,
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shrinkWrap: true,
                                  children: [
                                    'Delete',
                                  ]
                                      .map(
                                        (e) => InkWell(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
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
                      child: TabPageSelector(
                        controller: controller,
                      )),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, bottom: 8.0, right: 24.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircleAvatar(
                            radius: 34,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(widget.post!.spot!.logo!.url!),
                            ),
                          ),
                        ),
                        Container(
                          height: 34,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.post!.spot!.name!,
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .fontSize,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${widget.post!.spot!.types!.first.name!}・${widget.post!.spot!.location!.display}",
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .fontSize,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: GestureDetector(
                            onTap: () => saved = !saved,
                            child: Image(
                                image: AssetImage(saved
                                    ? 'assets/star.png'
                                    : 'assets/star_border.png'),
                                height: 34,
                                color: saved ? Colors.yellow : Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          // LIKE, COMMENT SECTION OF THE POST
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, top: 12.0, right: 12.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image(image: AssetImage('assets/map_border.png'), height: 30),
                Image(
                    image: AssetImage('assets/comments_border.png'),
                    height: 30),
                GestureDetector(
                    onTap: () => favourite = !favourite,
                    child: Image(
                        image: AssetImage(favourite
                            ? 'assets/heart.png'
                            : 'assets/heart_border.png'),
                        height: 30,
                        color: favourite ? Colors.pink : null)),
                Image(image: AssetImage('assets/send_border.png'), height: 30),
              ],
            ),
          ),
          //DESCRIPTION AND NUMBER OF COMMENTS
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${widget.post!.numberOfLikes!.toString()} likes ",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showAll = !showAll;
                    });
                  },
                  child: Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: "${widget.post!.author!.username!} ",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                            text: widget.post!.caption!.text!.length > length &&
                                    showAll
                                ? widget.post!.caption!.text!
                                        .substring(0, length) +
                                    "..."
                                : widget.post!.caption!.text!),
                        widget.post!.caption!.text!.length > length
                            ? WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showAll = !showAll;
                                    });
                                  },
                                  child: Text(
                                    showAll ? ' more' : ' less',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                  ),
                                ),
                              )
                            : TextSpan(),
                      ],
                    ),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                widget.post!.likedBy?.isNotEmpty ?? false
                    ? SizedBox(
                        height: 40,
                        child: ListView(
                          // This next line does the trick.
                          scrollDirection: Axis.horizontal,
                          children: widget.post!.likedBy!
                              .map<Widget>((e) => Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: OutlinedButton(
                                        onPressed: () {},
                                        child: Text(e!.username!)),
                                  ))
                              .toList(),
                        ),
                      )
                    : Container(),
                // DATE
                Container(
                  child: Text(
                    "${DateTime.now().difference(DateTime.parse(widget.post!.createdAt!)).inDays.toString()} days ago ",
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
