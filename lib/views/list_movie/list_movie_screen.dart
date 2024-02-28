// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:movie_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:movie_app/models/responses/movie_response_model.dart';

class ListViewMovieScreen extends StatefulWidget {
  ListViewMovieScreen({super.key});

  @override
  State<ListViewMovieScreen> createState() => _ListViewMovieScreenState();
}

class _ListViewMovieScreenState extends State<ListViewMovieScreen> {
 

  @override
  Widget build(BuildContext context) {

    List<Search> imgList = [];
    

    // Widget buildCarouselSlider() {
    //   final List<Widget> imageSliders = imgList
    //       .map((item) => Container(
    //             color: Colors.amber,
    //             child: ClipRRect(
    //                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
    //                 child: Stack(
    //                   children: <Widget>[
    //                     Image.network(
    //                       item.poster,
    //                       fit: BoxFit.fitWidth,
    //                     ),
    //                     Positioned(
    //                       bottom: 0.0,
    //                       left: 0.0,
    //                       right: 0.0,
    //                       child: Container(
    //                         decoration: const BoxDecoration(
    //                           gradient: LinearGradient(
    //                             colors: [
    //                               Color.fromARGB(200, 0, 0, 0),
    //                               Color.fromARGB(0, 0, 0, 0)
    //                             ],
    //                             begin: Alignment.bottomCenter,
    //                             end: Alignment.topCenter,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 )),
    //           ))
    //       .toList();

    //   return CarouselSlider(
    //     items: imageSliders,
    //     options: CarouselOptions(

    //       height: MediaQuery.sizeOf(context).height / 3,
    //       viewportFraction: 1,
    //       initialPage: 0,
    //       enableInfiniteScroll: true,
    //       reverse: false,
    //       autoPlay: true,
    //       autoPlayInterval: const Duration(seconds: 3),
    //       autoPlayAnimationDuration: const Duration(milliseconds: 800),
    //       autoPlayCurve: Curves.fastOutSlowIn,
    //       enlargeCenterPage: true,
    //       // enlargeFactor: 0.5,
    //       scrollDirection: Axis.horizontal,
    //     ),
    //   );
    // }

     Widget buildCarouselSlider() {
       final List<Widget> items = imgList
    .map(
      (item) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          child: Container(
            color: Colors.amber,
            width: double.infinity,
            height: 100,
            child: 
            Image.network(item.poster, fit: BoxFit.cover,),
            // Center(
            //   child: Text(
            //     item.title,
            //     style: const TextStyle(
            //       color: Colors.white,
            //       fontSize: 24.0,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
          ),
        ),
      ),
    )
    .toList();

      return FlutterCarousel(
  items: items,
  options: CarouselOptions(
    height: 400.0,
    aspectRatio: 16 / 9,
    viewportFraction: 1.0,
    initialPage: 0,
    enableInfiniteScroll: true,
    reverse: false,
    autoPlay: true,
    autoPlayInterval: const Duration(seconds: 2),
    autoPlayAnimationDuration: const Duration(milliseconds: 1000),
    autoPlayCurve: Curves.fastOutSlowIn,
    enlargeCenterPage: false,
    controller: CarouselController(),
    // onPageChanged: callbackFunction,
    pageSnapping: true,
    scrollDirection: Axis.horizontal,
    pauseAutoPlayOnTouch: true,
    pauseAutoPlayOnManualNavigate: true,
    pauseAutoPlayInFiniteScroll: false,
    enlargeStrategy: CenterPageEnlargeStrategy.scale,
    disableCenter: false,
    showIndicator: true,
    // floatingIndicator = true,
    slideIndicator: CircularSlideIndicator(),
  )
);
     }


    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            print(">>> state : ${state}");
            if (state is SuccessRandomMovie) {
              imgList = state.result.search;

             
              return buildCarouselSlider();
            }
            return SizedBox();
          },
        ),
        Container(
          margin: EdgeInsets.all(14),
          // color: Colors.amber,
          height: MediaQuery.sizeOf(context).height / 1.8,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Movie",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 2.3,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 25,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 14),
                      height: 100,
                      width: MediaQuery.sizeOf(context).width / 2,
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(
                                "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Keteranganaaaaaaaaaaaaaaaaaaaa adasdad",
                            maxLines: 2,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
