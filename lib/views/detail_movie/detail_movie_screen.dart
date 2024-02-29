import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:movie_app/models/responses/movie_detail_response_model.dart';
import 'package:movie_app/services/language_translation.dart';

class DetailMovieScreen extends StatelessWidget {
  DetailMovieScreen({super.key});

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LanguageTranslation.of(context)!.value('detail-movie'),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        buildWhen: (previous, current) =>
            previous != current && current is SuccessMovieDetail,
        builder: (context, state) {
          if (state is SuccessGetFavoriteMovie) {
            status = state.isFavorite;
          }

          print(state);
          if (state is SuccessMovieDetail) {
            MovieDetailResponseModel data = state.result;

            return ListView(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 2,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Image.network(
                          data.poster,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.white.withOpacity(.8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(data.genre),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.amber),
                                        const SizedBox(width: 10),
                                        Text(
                                          data.imdbRating,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "(${data.imdbVotes})",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    Text(data.genre)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      BlocBuilder<MovieBloc, MovieState>(
                        builder: (context, state) {
                          if (state is SuccessGetFavoriteMovie) {
                            status = state.isFavorite;
                          }

                          return Positioned(
                            top: 5,
                            right: 5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                  MediaQuery.sizeOf(context).width / 8,
                                  MediaQuery.sizeOf(context).width / 8,
                                ),
                                shape: const CircleBorder(),
                                backgroundColor:
                                    Colors.grey.shade300.withOpacity(.6),
                                padding: EdgeInsets.zero,
                              ),
                              child: Icon(
                                (status)
                                    ? Icons.favorite
                                    : Icons.favorite_border_rounded,
                                color: Colors.red,
                                size: MediaQuery.sizeOf(context).width / 14,
                              ),
                              onPressed: () {
                                context.read<MovieBloc>().add(
                                    SetFavoriteMovieEvent(
                                        movieId: data.imdbId, status: !status));

                                context.read<MovieBloc>().add(
                                      GetFavoriteMovieEvent(
                                        movieId: data.imdbId,
                                      ),
                                    );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  children: [
                    InfoDetailWidget(
                      title: "Story",
                      value: data.plot,
                    ),
                    InfoDetailWidget(
                      title: "Director",
                      value: data.director,
                    ),
                    InfoDetailWidget(
                      title: "Writer",
                      value: data.writer,
                    ),
                    InfoDetailWidget(
                      title: "Actors",
                      value: data.actors,
                    ),
                    InfoDetailWidget(
                      title: "Language",
                      value: data.language,
                    ),
                  ],
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}

class InfoDetailWidget extends StatelessWidget {
  const InfoDetailWidget({
    super.key,
    required this.title,
    required this.value,
  });

  // final MovieDetailResponseModel data;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(value),
    );
  }
}
