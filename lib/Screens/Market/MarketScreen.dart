import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Screens/Market/OneScreenMarket.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/MoreInfoProudct.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetProducts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetProductsModel.dart';

class MarketScreen extends StatefulWidget {
  MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  int initialPage = 0;
  final PageController controller = PageController(initialPage: 0);
  void nextPage(pageinit) {
    controller.animateToPage(pageinit,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Market'),
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          nextPage(0);
                          initialPage = 0;
                        });
                      },
                      child:
                          _card('all'.tr, initialPage == '0' ? true : false)),

                  for (var i = 1; i <= Products_Categories.length; i++)
                    InkWell(
                        onTap: () {
                          setState(() {
                            nextPage(i);
                            initialPage = i;
                          });
                        },
                        child: _card("${Products_Categories['$i']!.toString()}",
                            initialPage == '${i}' ? true : false)),

                  // InkWell(
                  //     onTap: () {
                  //       setState(() {
                  //         nextPage(2);
                  //         initialPage = 2;
                  //       });
                  //     },
                  //     child: _card('Autos & Vehicles'.tr,
                  //         initialPage == 2 ? true : false)),
                  // InkWell(
                  //   onTap: () {
                  //     setState(() {
                  //       nextPage(3);
                  //       initialPage = 3;
                  //     });
                  //   },
                  //   child: _card('Baby & Children\'s Products	'.tr,
                  //       initialPage == 3 ? true : false),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     setState(() {
                  //       nextPage(4);
                  //       initialPage = 4;
                  //     });
                  //   },
                  //   child: _card('Beauty Products & Services'.tr,
                  //       initialPage == 4 ? true : false),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     setState(() {
                  //       nextPage(5);
                  //       initialPage = 5;
                  //     });
                  //   },
                  //   child: _card('Computers & Peripherals',
                  //       initialPage == 5 ? true : false),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     setState(() {
                  //       nextPage(6);
                  //       initialPage = 6;
                  //     });
                  //   },
                  //   child: _card('Consumer Electronics'.tr,
                  //       initialPage == 6 ? true : false),
                  // ),
                  // InkWell(
                  //     onTap: () {
                  //       setState(() {
                  //         nextPage(7);
                  //         initialPage = 7;
                  //       });
                  //     },
                  //     child: _card('Financial Services	'.tr,
                  //         initialPage == 7 ? true : false)),
                  // InkWell(
                  //     onTap: () {
                  //       setState(() {
                  //         nextPage(8);
                  //         initialPage = 8;
                  //       });
                  //     },
                  //     child: _card('Gifts & Occasions	'.tr,
                  //         initialPage == 8 ? true : false)),
                  // InkWell(
                  //     onTap: () {
                  //       setState(() {
                  //         nextPage(9);
                  //         initialPage = 9;
                  //       });
                  //     },
                  //     child: _card(
                  //         'Home & Garden'.tr, initialPage == 9 ? true : false)),
                ],
              ),
            ),
          ),
          Container(
            height: Get.height * 0.80,
            width: Get.width,
            child: PageView(
              onPageChanged: (val) {
                setState(() {
                  initialPage = val;
                });
                print(initialPage);
              },
              controller: controller,
              children: [
                _All(
                  category_id: '0',
                  Categories: 'All Categories'.tr,
                ),
                for (var i = 1; i <= Products_Categories.length; i++)
                  _All(
                    category_id: '${i}',
                    Categories: "${Products_Categories['$i']!.toString()}",
                  ),


              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(name, color) {
    return Container(
      padding: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: color ? ColorTheme : Color.fromARGB(196, 255, 255, 255),
          borderRadius: BorderRadius.circular(50),

          // ]
          border:
              Border.all(color: color ? Colors.white : ColorTheme, width: 1)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: Text(
          name,
          style: GoogleFonts.cairo(
              color: color ? Colors.white : Color.fromARGB(255, 89, 87, 87),
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _All extends StatefulWidget {
  _All({
    required this.category_id,
    required this.Categories,
    super.key,
  });
  String category_id;
  String Categories;
  @override
  State<_All> createState() => _AllState();
}

class _AllState extends State<_All> {
  String? lastId;
  List<GetProudctsModel> data = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  void GetData() {
    ApiGetProudcts.getprodict('0', widget.category_id).then((value) {
      setState(() {
        data = value.toList();
        lastId = value[value.length - 1].id;
      });
    });
  }

  @override
  void initState() {
    GetData();
    super.initState();
  }

  void onLoding() async {
    // await Future.delayed(Duration(seconds: 3));
    var list = await ApiGetProudcts.getprodict(lastId!, widget.category_id);

    // print('onLoding');
    // print(lastId);
    // print(list.length - 1);
    list.length - 1 == -1 ? '' : lastId = list[list.length - 1].id;

    // if (list.length - 1 == -1) {
    //   post = true;
    // } else {
    //   post = false;
    // }
    setState(() {
      refreshController.loadComplete();
      lastId == null ? dispose() : data.addAll(list);
    });
  }

  void onRefresh() async {
    var list = await ApiGetProudcts.getprodict('0', widget.category_id);

    setState(() {
      data.clear();
      data.addAll(list.toList());

      refreshController.refreshCompleted();

      lastId = data[data.length - 1].id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Text(
            widget.Categories,
            style: GoogleFonts.cairo(fontWeight: FontWeight.w700, fontSize: 17),
          ),
        ),
        Expanded(
          child: SmartRefresher(
            onRefresh: onRefresh,
            onLoading: onLoding,
            enablePullUp: true,
            enablePullDown: true,
            controller: refreshController,
            child: GridView.count(
              crossAxisCount: 2,
              scrollDirection: Axis.vertical,
              primary: false,
              children: List.generate(data.length, (index) {
          
                return InkWell(
                  onTap: (){
                    Get.to(Onescreenmarket(title: data[index].name,));
                  },
                  child: Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(

                        ),
                        // width: Get.width,
                        // height: Get.height *0.1,
                        child: Stack(children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: data[index].images,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Text(data[index].name),
                      Text(data[index].price)
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

class _MoreInfoProudct extends StatefulWidget {
  _MoreInfoProudct(
      {required this.location,
      required this.currency,
      required this.name,
      required this.images,
      required this.price,
      required this.edit_description,
      super.key});

  String location;
  String currency;
  String name;
  final images;
  String price;
  String edit_description;

  @override
  State<_MoreInfoProudct> createState() => __MoreInfoProudctState();
}

class __MoreInfoProudctState extends State<_MoreInfoProudct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: Get.height * 0.40,
                    flexibleSpace: FlexibleSpaceBar(
                      background: PageView.builder(
                          itemCount: widget.images.length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              widget.images[index]['image'],
                              fit: BoxFit.cover,
                            );
                          }),
                    ),

                    backgroundColor: ColorTheme,
                    elevation: 1,
                    centerTitle: false,
                    // bottom: Tab(child: _WidgetBotoomTapPar(cont2: cont2)),
                    floating: true,
                    snap: true,
                    title: Text(
                      'ameen',
                      style: TextStyle(color: Colors.black),
                    ),
                    actions: [],
                  )
                ];
              },
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Get.width * 0.6,
                                  child: Text(
                                    widget.name,
                                    style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Container(
                                    width: Get.width * 0.40,
                                    child: Text(widget.location))
                              ],
                            ),
                            Container(
                              width: Get.width * 0.3,
                              child: Text(
                                CurrencyConverter(Currency_Array[
                                        int.parse(widget.currency)]) +
                                    ' ' +
                                    widget.price,
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        Divider(),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Html(data: widget.edit_description),

                        // Text(
                        //   widget.edit_description,
                        //   style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue[700],
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.message,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.01,
                                    ),
                                    Text(
                                      'Message'.tr,
                                      style: GoogleFonts.cairo(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.orange[700],
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Text(
                                  'Buy Now'.tr,
                                  style: GoogleFonts.cairo(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
