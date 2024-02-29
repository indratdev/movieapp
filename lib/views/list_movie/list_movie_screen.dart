// import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:movie_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:movie_app/models/responses/movie_response_model.dart';
import 'package:movie_app/services/language_translation.dart';

import 'package:movie_app/views/detail_movie/detail_movie_screen.dart';

class ListViewMovieScreen extends StatefulWidget {
  ListViewMovieScreen({super.key});

  @override
  State<ListViewMovieScreen> createState() => _ListViewMovieScreenState();
}

class _ListViewMovieScreenState extends State<ListViewMovieScreen> {
  @override
  Widget build(BuildContext context) {
    List<Search> imgList = [];

    Widget buildCarouselSlider() {
      final List<Widget> items = imgList
          .map(
            (item) => ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              child: SizedBox(
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: item.poster,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                // Image.network(
              ),
            ),
          )
          .toList();

      return FlutterCarousel(
          items: items,
          options: CarouselOptions(
            height: MediaQuery.sizeOf(context).height / 1.8,
            aspectRatio: 16 / 9,
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            controller: CarouselController(),
            pageSnapping: true,
            scrollDirection: Axis.horizontal,
            pauseAutoPlayOnTouch: true,
            pauseAutoPlayOnManualNavigate: true,
            pauseAutoPlayInFiniteScroll: false,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            disableCenter: false,
            showIndicator: true,
            floatingIndicator: true,
            slideIndicator: const CircularSlideIndicator(),
          ));
    }

    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        BlocBuilder<MovieBloc, MovieState>(
          buildWhen: (previous, current) =>
              previous != current && current is SuccessRandomMovie,
          builder: (context, state) {
            if (state is LoadingRandomMovie) {
              Center(child: const CircularProgressIndicator.adaptive());
            }

            if (state is SuccessRandomMovie) {
              imgList = state.result.search;
              return buildCarouselSlider();
            }
            return const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator.adaptive()),
            );
          },
        ),
        BlocBuilder<MovieBloc, MovieState>(
          buildWhen: (previous, current) =>
              previous != current && current is SuccessMovieByTitle,
          builder: (context, state) {
            if (state is SuccessMovieByTitle) {
              MovieResponseModel datasMovieByTitle = state.result;

              return Container(
                margin: EdgeInsets.all(14),
                // color: Colors.amber,
                height: MediaQuery.sizeOf(context).height / 1.8,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LanguageTranslation.of(context)!
                              .value('popular-movie'),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            LanguageTranslation.of(context)!.value('see-all'),
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
                        itemCount: datasMovieByTitle.search.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          Search dataMovie = datasMovieByTitle.search[index];

                          return InkWell(
                            onTap: () {
                              context.read<MovieBloc>().add(
                                  GetMovieDetail(idMovie: dataMovie.imdbId));
                              context.read<MovieBloc>().add(
                                  GetFavoriteMovieEvent(
                                      movieId: dataMovie.imdbId));

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailMovieScreen(),
                                  ));
                            },
                            child: MovieGeneralWidget(dataMovie: dataMovie),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }
            return SizedBox();
          },
        ),
      ],
    );
  }
}

class MovieGeneralWidget extends StatefulWidget {
  MovieGeneralWidget({
    super.key,
    required this.dataMovie,
    this.status = false,
    this.showFavoriteIcon = true,
  });

  final Search dataMovie;
  bool status;
  bool showFavoriteIcon;

  @override
  State<MovieGeneralWidget> createState() => _MovieGeneralWidgetState();
}

class _MovieGeneralWidgetState extends State<MovieGeneralWidget> {
  @override
  void initState() {
    context
        .read<MovieBloc>()
        .add(GetFavoriteMovieEvent(movieId: widget.dataMovie.imdbId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 14),
      height: 100,
      width: MediaQuery.sizeOf(context).width / 2,
      // color: Colors.blue,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CachedNetworkImage(
                    imageUrl: (widget.dataMovie.poster != "N/A")
                        ? widget.dataMovie.poster
                        : "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    if (state is SuccessGetFavoriteMovie) {
                      widget.status = state.isFavorite;
                    }

                    return (widget.showFavoriteIcon)
                        ? Positioned(
                            bottom: 5,
                            right: 0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                backgroundColor:
                                    Colors.grey.shade300.withOpacity(.6),
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {},
                              child: Icon(
                                  (widget.status)
                                      ? Icons.favorite
                                      : Icons.favorite_border_rounded,
                                  color: Colors.red),
                            ),
                          )
                        : SizedBox();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 22,
            child: Text(
              widget.dataMovie.title,
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
