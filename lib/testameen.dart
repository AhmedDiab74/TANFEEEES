// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:freedoms/Screen/Home/WidgetDrawer.dart';
// import 'package:freedoms/String.dart';
// import 'package:freedoms/Utilit/Function.dart';
// import 'package:freedoms/colors.dart';
// import 'package:freedoms/images.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   bool close_wilcome = true;
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color(0xffF8F8F8),
//         drawer: Widgetdrawer(),
//         appBar: AppBar(
//           actions: [
//             SvgPicture.asset(
//               svgnappar.messages,
//               width: 30,
//               height: 30,
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             SvgPicture.asset(
//               svgnappar.add,
//               width: 30,
//               height: 30,
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             SvgPicture.asset(
//               svgnappar.search,
//               width: 30,
//               height: 30,
//             ),
//           ],
//           centerTitle: false,
//           title: Image.asset(
//             'assets/logo.png',
//             width: 150,
//           ),
//           backgroundColor: Colors.white,
//           elevation: 1,
//           surfaceTintColor: Colors.white,
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               if (close_wilcome)
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Good evening, $nameApp',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 25,
//                             color: Color(0xff3F51B5)),
//                       ),
//                       IconButton(
//                           onPressed: () {
//                             setState(() {
//                               close_wilcome = false;
//                             });
//                           },
//                           icon: Icon(
//                             Icons.cancel_outlined,
//                             color: Colors.grey,
//                           ))
//                     ],
//                   ),
//                 ),

//               //story
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     //Create new story
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: 150,
//                           height: 275,
//                           child: Stack(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 8),
//                                 child: Container(
//                                   height: 220,
//                                   width: 130,
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                         image: CachedNetworkImageProvider(
//                                             'https://imgv3.fotor.com/images/slider-image/A-clear-close-up-photo-of-a-woman.jpg'),
//                                         fit: BoxFit.cover),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                   bottom: 0,
//                                   left: 0,
//                                   right: 0,
//                                   child: Column(
//                                     children: [
//                                       CircleAvatar(
//                                           backgroundColor: Colors.black,
//                                           maxRadius: 24.1,
//                                           child: CircleAvatar(
//                                             maxRadius: 24,
//                                             backgroundColor: Colors.white,
//                                             child: Icon(
//                                               Icons.add,
//                                               size: 30,
//                                             ),
//                                           )),
//                                       SizedBox(
//                                         height: sizedHeight(context) * 0.008,
//                                       ),
//                                       Text(
//                                         'Create new story',
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.bold),
//                                       )
//                                     ],
//                                   )),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),

//                     //Create new story
//                     //allStorys

//                     for (var i = 0; i < 10; i++)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: 138.8,
//                             height: 275,
//                             child: Stack(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 0, vertical: 8),
//                                   child: Container(
//                                     height: 220,
//                                     width: 130,
//                                     decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                           image: CachedNetworkImageProvider(
//                                               'https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg'),
//                                           fit: BoxFit.cover),
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                     bottom: 0,
//                                     left: 0,
//                                     right: 0,
//                                     child: Column(
//                                       children: [
//                                         CircleAvatar(
//                                             backgroundColor: Colors.black,
//                                             maxRadius: 24.1,
//                                             child: CircleAvatar(
//                                               maxRadius: 24,
//                                               backgroundImage:
//                                                   CachedNetworkImageProvider(
//                                                       'https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-800x525.jpg'),
//                                             )),
//                                         SizedBox(
//                                           height: sizedHeight(context) * 0.008,
//                                         ),
//                                         Text(
//                                           'Ameen Hamed',
//                                           style: TextStyle(
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.bold),
//                                         )
//                                       ],
//                                     )),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//               //story

//               //add post
//               SizedBox(
//                 height: sizedHeight(context) * 0.02,
//               ),
//               Container(
//                 width: sizedWidth(context),
//                 color: Colors.white,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: CircleAvatar(
//                         backgroundImage: CachedNetworkImageProvider(
//                             'https://freedoms-app.com/upload/photos/2024/04/w3SadCGHiRyiO1bxXL4r_08_5736f10ea4df1d7f30a90d9a278c4aad_avatar_full.png'),
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(7),
//                           color: Color(0xffEBEEF0)),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 7, vertical: 14),
//                         child: Text(
//                           'What\'s going on? #Hashtag.. @Mention.. Link..',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 12),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: CircleAvatar(
//                         child: Icon(
//                           Icons.camera_alt,
//                           color: Color(0xff4CAF50),
//                         ),
//                         backgroundColor: Color(0xffEEF7EF),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               //Reels
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 decoration: BoxDecoration(color: Colors.white, boxShadow: [
//                   BoxShadow(color: Color.fromARGB(58, 0, 0, 0), blurRadius: 0.1)
//                 ]),
//                 width: sizedWidth(context),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Image.asset(
//                             'assets/images/33Hxs1Fsi4m.png',
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             'Reels and short videos',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w500, fontSize: 15),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             for (var i = 0; i < 10; i++)
//                               Row(
//                                 children: [
//                                   Stack(
//                                     children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             image: DecorationImage(
//                                                 image:
//                                                     CachedNetworkImageProvider(
//                                                   'https://imgv3.fotor.com/images/slider-image/A-clear-image-of-a-woman-wearing-red-sharpened-by-Fotors-image-sharpener.jpg',
//                                                 ),
//                                                 fit: BoxFit.cover)),
//                                         width: sizedWidth(context) * 0.50,
//                                         height: sizedHeight(context) * 0.40,
//                                       ),
//                                       Positioned(
//                                           top: 10,
//                                           left: 10,
//                                           child: CircleAvatar(
//                                               backgroundColor: ColorsThem,
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(1.0),
//                                                 child: CircleAvatar(
//                                                   backgroundImage:
//                                                       CachedNetworkImageProvider(
//                                                           'https://imgv3.fotor.com/images/slider-image/A-clear-close-up-photo-of-a-woman.jpg'),
//                                                 ),
//                                               ))),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     width: 8,
//                                   ),
//                                 ],
//                               ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
