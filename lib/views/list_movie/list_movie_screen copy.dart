// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_app/blocs/movie_bloc/movie_bloc.dart';
// import 'package:movie_app/models/responses/movie_response_model.dart';

// class ListViewMovieScreen extends StatefulWidget {
//   ListViewMovieScreen({super.key});

//   @override
//   State<ListViewMovieScreen> createState() => _ListViewMovieScreenState();
// }

// class _ListViewMovieScreenState extends State<ListViewMovieScreen> {
//   // final List<String> imgList = [
//   //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//   //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//   //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   //   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   //   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   //   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
//   // ];

//   List<Search> imgList = [];

//   @override
//   Widget build(BuildContext context) {
//     // final List<Widget> imageSliders = imgList
//     //     .map((item) => Container(
//     //           color: Colors.amber,
//     //           // margin: EdgeInsets.all(5.0),
//     //           child: ClipRRect(
//     //               borderRadius: BorderRadius.all(Radius.circular(5.0)),
//     //               child: Stack(
//     //                 children: <Widget>[
//     //                   Image.network(
//     //                     item.poster,
//     //                     fit: BoxFit.cover,
//     //                   ),
//     //                   Positioned(
//     //                     bottom: 0.0,
//     //                     left: 0.0,
//     //                     right: 0.0,
//     //                     child: Container(
//     //                       decoration: const BoxDecoration(
//     //                         gradient: LinearGradient(
//     //                           colors: [
//     //                             Color.fromARGB(200, 0, 0, 0),
//     //                             Color.fromARGB(0, 0, 0, 0)
//     //                           ],
//     //                           begin: Alignment.bottomCenter,
//     //                           end: Alignment.topCenter,
//     //                         ),
//     //                       ),
//     //                     ),
//     //                   ),
//     //                 ],
//     //               )),
//     //         ))
//     //     .toList();

//     Widget buildCarouselSlider() {
//       final List<Widget> imageSliders = imgList
//           .map((item) => Container(
//                 color: Colors.amber,
//                 child: ClipRRect(
//                     borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                     child: Stack(
//                       children: <Widget>[
//                         Image.network(
//                           item.poster,
//                           fit: BoxFit.fitWidth,
//                         ),
//                         Positioned(
//                           bottom: 0.0,
//                           left: 0.0,
//                           right: 0.0,
//                           child: Container(
//                             decoration: const BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Color.fromARGB(200, 0, 0, 0),
//                                   Color.fromARGB(0, 0, 0, 0)
//                                 ],
//                                 begin: Alignment.bottomCenter,
//                                 end: Alignment.topCenter,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )),
//               ))
//           .toList();

//       return CarouselSlider(
//         items: imageSliders,
//         options: CarouselOptions(

//           height: MediaQuery.sizeOf(context).height / 3,
//           viewportFraction: 1,
//           initialPage: 0,
//           enableInfiniteScroll: true,
//           reverse: false,
//           autoPlay: true,
//           autoPlayInterval: const Duration(seconds: 3),
//           autoPlayAnimationDuration: const Duration(milliseconds: 800),
//           autoPlayCurve: Curves.fastOutSlowIn,
//           enlargeCenterPage: true,
//           // enlargeFactor: 0.5,
//           scrollDirection: Axis.horizontal,
//         ),
//       );
//     }

//     return ListView(
//       scrollDirection: Axis.vertical,
//       shrinkWrap: true,
//       children: [
//         BlocBuilder<MovieBloc, MovieState>(
//           builder: (context, state) {
//             print(">>> state : ${state}");
//             if (state is SuccessRandomMovie) {
//               imgList = state.result.search;

//               // return CarouselSlider(
//               //   items: imageSliders,
//               //   options: CarouselOptions(
//               //     height: MediaQuery.sizeOf(context).height / 3,
//               //     viewportFraction: 1,
//               //     initialPage: 0,
//               //     enableInfiniteScroll: true,
//               //     reverse: false,
//               //     autoPlay: true,
//               //     autoPlayInterval: const Duration(seconds: 3),
//               //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
//               //     autoPlayCurve: Curves.fastOutSlowIn,
//               //     enlargeCenterPage: true,
//               //     enlargeFactor: 0.5,
//               //     // onPageChanged: callbackFunction,
//               //     scrollDirection: Axis.horizontal,
//               //   ),
//               // );
//               return buildCarouselSlider();
//             }
//             return SizedBox();
//           },
//         ),
//         Container(
//           margin: EdgeInsets.all(14),
//           // color: Colors.amber,
//           height: MediaQuery.sizeOf(context).height / 1.8,
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Popular Movie",
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: Text(
//                       "See all",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height / 2.3,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: 25,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.only(right: 14),
//                       height: 100,
//                       width: MediaQuery.sizeOf(context).width / 2,
//                       // color: Colors.blue,
//                       child: Column(
//                         children: [
//                           Expanded(
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(14),
//                               child: Image.network(
//                                 "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Text(
//                             "Keteranganaaaaaaaaaaaaaaaaaaaa adasdad",
//                             maxLines: 2,
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
