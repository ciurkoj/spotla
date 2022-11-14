import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:spotlas/widgets/like_animation.dart';
import 'package:spotlas/models/post.dart';

import '../change notifiers/post_list_change_notifier.dart';

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
  bool isLikeAnimating = false;

  late PostListChangeNotifier postListCN;

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
    postListCN = Provider.of<PostListChangeNotifier>(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onDoubleTap: () {
              if (favourite) {
                postListCN.removeFavourite(widget.post!);
              } else {
                postListCN.setFavourite(widget.post!);
              }
              setState(() {
                favourite = !favourite;
                isLikeAnimating = favourite;
              });
            },
            child: Stack(
              children: [
                SizedBox(
                  height: _size?.height ?? 300,
                  child: MeasureSize(
                    onChange: (Size value) {
                      if (mounted) {
                        setState(() {
                          if (_size != null) {
                            double x = value.width / _size!.width;
                            _size = Size(value.width, value.height * x);
                          }
                        });
                      }
                    },
                    child: PageView.builder(
                        onPageChanged: (int page) {
                          controller?.index = page;
                        },
                        itemCount: widget.post!.media!.length,
                        pageSnapping: true,
                        padEnds: false,
                        itemBuilder: (context, pagePosition) {
                          Image image = Image.network(
                            widget.post!.media![pagePosition]!.url!,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Loading media..."),
                                    ),
                                    CircularProgressIndicator(
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress
                                                  .expectedTotalBytes!
                                          : null,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                          _calculateImageDimension(image).then((size) {
                            if (mounted && _size == null) {
                              setState(() {
                                _size = size;
                              });
                            }
                          });
                          return image;
                        }),
                  ),
                ),
                Container(
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
                                  shadows: const [
                                    Shadow(color: Colors.black, blurRadius: 20)
                                  ],
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
                                  shadows: const [
                                    Shadow(color: Colors.black, blurRadius: 20)
                                  ],
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
                          SizedBox(
                            height: 34,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.post!.spot!.name!,
                                  style: TextStyle(
                                    shadows: const [
                                      Shadow(
                                          color: Colors.black, blurRadius: 20)
                                    ],
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
                                    shadows: const [
                                      Shadow(
                                          color: Colors.black, blurRadius: 20)
                                    ],
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
                          GestureDetector(
                            onTap: () {
                              if (!saved) {
                                postListCN.setSaved(widget.post!);
                              } else {
                                postListCN.removeSaved(widget.post!);
                              }
                              saved = !saved;
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
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
                ),
                Positioned.fill(
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 1000),
                      opacity: isLikeAnimating ? 1 : 0,
                      child: LikeAnimation(
                        isAnimating: isLikeAnimating,
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 100,
                        ),
                        duration: const Duration(milliseconds: 2000),
                        onEnd: () {
                          setState(() {
                            isLikeAnimating = false;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // LIKE, COMMENT SECTION OF THE POST
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, top: 12.0, right: 12.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Image(
                    image: AssetImage('assets/map_border.png'), height: 30),
                const Image(
                    image: AssetImage('assets/comments_border.png'),
                    height: 30),
                GestureDetector(
                    onTap: () => {
                          setState(() {
                            favourite = !favourite;
                          })
                        },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                          image: AssetImage(favourite
                              ? 'assets/heart.png'
                              : 'assets/heart_border.png'),
                          height: 30,
                          color: favourite ? Colors.pink : null),
                    )),
                const Image(
                    image: AssetImage('assets/send_border.png'), height: 30),
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
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                  ),
                                ),
                              )
                            : const TextSpan(),
                      ],
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18),
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

  Future<Size> _calculateImageDimension(Image image) {
    Completer<Size> completer = Completer();
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

typedef OnWidgetSizeChange = void Function(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant MeasureSizeRenderObject renderObject) {
    renderObject.onChange = onChange;
  }
}
