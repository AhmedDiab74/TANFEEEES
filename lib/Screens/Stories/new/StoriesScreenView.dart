import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Screens/Home/ContHomeScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Stories/new/AdsStroryScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Stories/new/HeartAnimation.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Functions.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiDeleteStores.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetByIdStories.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetUserViewStories.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiReactionStory.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiSentMessageStory.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/FetchUserViewStories.dart';
import 'package:wowondertimelineflutterapp/main.dart';

import 'user_model.dart';

class NewStoreViw extends StatefulWidget {
  NewStoreViw({super.key, required this.cont, required this.initialPage});
  final ContHomeScreen cont;
  final int initialPage;
  @override
  State<NewStoreViw> createState() => _NewStoreViwState();
}

class _NewStoreViwState extends State<NewStoreViw> {
  PageController? _pageController;
  final _key = GlobalKey();

  @override
  void initState() {
    print('klasjdklajskldjaskldjaksd ${widget.initialPage}');
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
    _pageController!.addListener(() {
      print("inside listener");
       if (_pageController!.initialPage+1 == widget.cont.stor.length) {
              Get.back();
            }
    });
  }

  void dispose() {
    _pageController?.dispose();

    super.dispose();
  }

  int StopPage = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: PageView.builder(
          padEnds: false,
          onPageChanged: (val) {
            if (val+1 == widget.cont.stor.length) {
              Get.back();
            }
          },
          controller: _pageController,
          itemCount: widget.cont.stor.length + 1,
          itemBuilder: (context, index) {
            final User user = User(
              name: widget.cont.stor[index].name,
              profileImageUrl: widget.cont.stor[index].avatar,
            );

            List<Story> storiess = [
              for (var i = 0; i < widget.cont.stor[index].storiess.length; i++)
                Story(
                  id_ads: widget.cont.stor[index].storiess[i].ad_id,
                  countLike: widget.cont.stor[index].storiess[i].countLike,
                  user_id: widget.cont.stor[index].storiess[i].user_id,
                  view_count: widget.cont.stor[index].storiess[i].view_count,
                  is_reacted: widget.cont.stor[index].storiess[i].is_reacted,
                  story_id: widget.cont.stor[index].storiess[i].id,
                  is_owner: widget.cont.stor[index].storiess[i].is_owner,
                  time: widget.cont.stor[index].storiess[i].time_text,
                  url: widget.cont.stor[index].storiess[i].videos.length > 0
                      ? widget
                          .cont
                          .stor[index]
                          .storiess[i]
                          .videos[widget
                                  .cont.stor[index].storiess[i].videos.length -
                              1]
                          .filename
                      : widget.cont.stor[index].storiess[i].thumbnail,
                  media: widget.cont.stor[index].storiess[i].videos.length > 0
                      ? MediaType.video
                      : MediaType.image,
                  duration:
                      widget.cont.stor[index].storiess[i].videos.length > 0
                          ? Duration(seconds: 50)
                          : Duration(seconds: 10),
                  user: user,
                ),
            ];
            return StoryScreen(
              cont: widget.cont,
              pagecont: _pageController!,
              stories: storiess,
              refresh: '',
              user_id: mydata.data[0].user_id,
              currentIndex: index,
            );
          }),
    );
  }
}

class StoryScreen extends StatefulWidget {
  final List<Story> stories;
  final PageController pagecont;
  final refresh;
  final String user_id;
  int currentIndex;
  final ContHomeScreen cont;
  StoryScreen(
      {required this.stories,
      required this.cont,
      required this.currentIndex,
      required this.refresh,
      required this.user_id,
      required this.pagecont});

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  PageController? _pageController;
  AnimationController? _animController;
  CachedVideoPlayerPlusController? _videoController;
  int _currentIndex = 0;
  bool playFalse = false;
  TextEditingController _textCont = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (mounted) {
      _pageController = PageController();
      _animController = AnimationController(vsync: this);

      final Story firstStory = widget.stories.first;
      _loadStory(story: firstStory, animateToPage: false);

      _animController!.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animController?.stop();
          _animController?.reset();
          setState(() {
            if (_currentIndex + 1 < widget.stories.length) {
              _currentIndex += 1;
              _loadStory(story: widget.stories[_currentIndex]);
            } else {
              widget.pagecont.nextPage(
                  duration: Duration(microseconds: 1), curve: Curves.bounceIn);

              _currentIndex = 0;
              _loadStory(story: widget.stories[_currentIndex]);
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    // widget.refresh();
    _videoController?.pause();
    _videoController?.dispose();
    _pageController?.dispose();
    _animController?.dispose();
    widget.pagecont.dispose();
    super.dispose();
  }

  void ameen() {
    setState(() {
      _animController!.repeat();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Story story = widget.stories[_currentIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onLongPressEnd: (val) {
          if (playFalse) {
            if (mounted) {
              _pageController!.initialPage;
              setState(() {
                _animController!.repeat();

                playFalse = false;
              });
              setState(() {
                if (story.media == MediaType.video) {
                  _videoController!.play();
                }
              });
            }
          }
        },
        onLongPress: () {
          if (mounted) {
            setState(() {
              playFalse = true;
              _animController!.stop();
            });
          }
        },
        onTapDown: (details) {
          _onTapDown(details, story);
          _videoController?.pause();
        },
        child: Dismissible(
          key: Key(story.user_id),
          direction: DismissDirection.up, // or whatever
          confirmDismiss: (direction) {
            if (direction == DismissDirection.up) {
              // or other directions
              // Swiped up do your thing.
              _animController!.stop();
              _videoController?.pause();

              Get.bottomSheet(
                  backgroundColor: Colors.black,
                  isScrollControlled: true,
                  ViewUserStories(
                    story_id: story.story_id,
                    view_count: widget.stories[_currentIndex].view_count,
                    onFalse: () {
                      if (mounted) {
                        _animController!.repeat();
                        if (story.media == MediaType.video) {
                          _videoController!.play();
                        }
                      }
                    },
                  ));
            }
            return Future.value(
                false); // always deny the actual dismiss, else it will expect the widget to be removed
          },
          child: Stack(
            children: <Widget>[
              PageView.builder(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.stories.length,
                itemBuilder: (context, i) {
                  final Story story = widget.stories[i];
                  ApiGetByIdStories.id(story_id: story.story_id);
                  switch (story.media) {
                    case MediaType.image:
                      return story.id_ads.isNotEmpty
                          ? GetAdsStory(
                              ad_id: story.id_ads,
                            )
                          : CachedNetworkImage(
                              imageUrl: story.url,
                              fit: BoxFit.cover,
                            );
                    case MediaType.video:
                      if (_videoController != null &&
                          _videoController!.value.isInitialized) {
                        return FittedBox(
                          child: SizedBox(
                            width: _videoController!.value.size.width,
                            height: _videoController!.value.size.height,
                            child: CachedVideoPlayerPlus(_videoController!),
                          ),
                        );
                      }
                  }
                  return const SizedBox.shrink();
                },
              ),
              Positioned(
                top: 60.0,
                left: 10.0,
                right: 10.0,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: widget.stories
                          .asMap()
                          .map((i, e) {
                            return MapEntry(
                              i,
                              AnimatedBar(
                                animController: _animController!,
                                position: i,
                                currentIndex: _currentIndex,
                              ),
                            );
                          })
                          .values
                          .toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 1.5,
                        vertical: 10.0,
                      ),
                      child: UserInfo(
                        like: story.countLike,
                        delete: () {
                          ApiDeleteSroties.dele(story_id: story.story_id);

                          setState(() {
                            widget.stories.removeAt(_currentIndex);
                            _currentIndex = 0;
                          });

                          if (widget.stories.length == 0) {
                            Navigator.of(context).pop();
                          } else {}
                        },
                        mystory: story.is_owner,
                        user: story.user,
                        time: widget.stories[_currentIndex].time,
                      ),
                    ),
                  ],
                ),
              ),
              if (story.user_id == widget.user_id)
                Positioned(
                  bottom: 0,
                  child: InkWell(
                    onTap: () {
                      _animController!.stop();
                      _videoController?.pause();

                      Get.bottomSheet(
                          backgroundColor:Colors.white,
                          isScrollControlled: true,
                          ViewUserStories(
                            story_id: story.story_id,
                            view_count:
                                widget.stories[_currentIndex].view_count,
                            onFalse: () {
                              if (mounted) {
                                _animController!.repeat();
                                if (story.media == MediaType.video) {
                                  _videoController!.play();
                                }
                              }
                            },
                          ));
                    },
                    child: Container(
                      width: sizedwidth(context),
                      decoration: BoxDecoration(color: ColorTheme),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                    widget.stories[_currentIndex].view_count
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'View Stories',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (story.user_id != widget.user_id)
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: sizedwidth(context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff191A21)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: sizedwidth(context) * 0.70,
                              decoration: BoxDecoration(
                                  color: ColorTheme,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  controller: _textCont,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Send Message',
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                                onTap: () {
                                  ApiReactionStories.reaction(
                                      story_id: widget
                                          .stories[_currentIndex].story_id,
                                      reaction: '2');
                                  popUp();
                                  setState(() {
                                    story.countLike++;
                                    widget.stories[_currentIndex].is_reacted =
                                        true;
                                  });
                                },
                                child: SvgPicture.asset(
                                  widget.stories[_currentIndex].is_reacted
                                      ? 'assets/svg/all/liked.svg'
                                      : 'assets/svg/all/like.svg',
                                  width: 35,
                                  height: 35,
                                  color:
                                      widget.stories[_currentIndex].is_reacted
                                          ? Colors.redAccent
                                          : Colors.white,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                ApiSentMessageSotory.send(
                                    user_id: story.user_id,
                                    text: _textCont.text,
                                    story_id: story.story_id);
                                _textCont.clear();
                              },
                              child: SvgPicture.asset(
                                'assets/svg/all/send.svg',
                                width: 30,
                                height: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              heartPop(),
            ],
          ),
        ),
      ),
    );
  }

  int _key = 0;
  final List<Widget> _hearts = <Widget>[];
  void popUp() async {
    if (mounted) {
      setState(() {
        _hearts.addAll([
          HeartAnimation(key: Key((_key + 1).toString())),
        ]);
        _key += 3;
      });

      void removeHeart(Key? key) {
        _hearts.clear();
      }
    }
  }

  Widget heartPop() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: sizedwidth(context),
            child: Stack(
              children: [
                for (var i = 0; i < _hearts.length; i++) HeartAnimation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details, Story story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadStory(story: widget.stories[_currentIndex]);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentIndex + 1 < widget.stories.length) {
          _currentIndex += 1;
          _loadStory(story: widget.stories[_currentIndex]);
        } else {
          // Out of bounds - loop story
          // You can also Navigator.of(context).pop() here
          widget.pagecont.nextPage(
              duration: Duration(microseconds: 1), curve: Curves.bounceIn);

          _videoController?.pause();
          _currentIndex = 0;
          _loadStory(story: widget.stories[_currentIndex]);
        }
      });
    } else {
      if (story.media == MediaType.video) {
        if (_videoController!.value.isPlaying) {
          _videoController?.pause();
          _animController?.stop();
        } else {
          _videoController?.pause();

          _videoController?.play();
          _animController?.forward();
        }
      }
    }
  }

  void _loadStory({required Story story, bool animateToPage = true}) {
    _animController!.stop();
    _animController!.reset();
    switch (story.media) {
      case MediaType.image:
        _animController!.duration = story.duration;
        _animController!.forward();

        break;
      case MediaType.video:
        _videoController = null;
        _videoController?.dispose();
        // ignore: deprecated_member_use
        _videoController =
            CachedVideoPlayerPlusController.networkUrl(story.url.toUri)
              ..initialize().then((_) {
                setState(() {});
                if (_videoController!.value.isInitialized) {
                  _animController?.duration = _videoController?.value.duration;
                  _videoController?.play();
                  _animController?.forward();
                }
              });
        break;
    }
    if (animateToPage) {
      _pageController!.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}

class ViewUserStories extends StatefulWidget {
  ViewUserStories({
    this.onFalse,
    super.key,
    required this.view_count,
    required this.story_id,
  });
  final onFalse;
  final String story_id;
  final int view_count;

  @override
  State<ViewUserStories> createState() => _ViewUserStoriesState();
}

class _ViewUserStoriesState extends State<ViewUserStories> {
  List<FetchUserViewStories> vSt = [];
  getData() async {
    vSt.clear();
    await ApiGetUserViewStories.get(story_id: widget.story_id).then((value) {
      setState(() {
        vSt = value.toList();
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void dispose() {
    widget.onFalse();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: sizedHeight(context) * 0.1,
        ),
        Center(
            child: Container(
          color: Colors.white,
          width: 100,
          height: 2,
        )),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: sizedHeight(context) * 0.85,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 0; i < vSt.length; i++)
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      maxRadius: 27,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                          maxRadius: 25,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  vSt[i].avatar))),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      vSt[i].name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar({
    key,
    required this.animController,
    required this.position,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex ? Color(0xff883D4A) : Colors.white,
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                        animation: animController,
                        builder: (context, child) {
                          return _buildContainer(
                            constraints.maxWidth * animController.value,
                            Color(0xff883D4A),
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final User user;
  final String time;
  final int like;
  final bool mystory;
  final delete;

  const UserInfo({
    required this.mystory,
    required this.like,
    required this.delete,
    key,
    required this.user,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.grey[300],
          backgroundImage: CachedNetworkImageProvider(
            user.profileImageUrl,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    time,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    maxRadius: 15,
                    backgroundColor: const Color.fromARGB(55, 0, 0, 0),
                    child: SvgPicture.asset('assets/svg/all/liked.svg'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      color: const Color.fromARGB(55, 0, 0, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          like.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            if (mystory)
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  size: 30.0,
                  color: Colors.white,
                ),
                onPressed: () {
                  delete();
                },
              ),
            IconButton(
              icon: const Icon(
                Icons.close,
                size: 30.0,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ],
    );
  }
}
