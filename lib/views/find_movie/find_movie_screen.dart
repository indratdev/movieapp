import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:movie_app/models/responses/movie_response_model.dart';
import 'package:movie_app/services/language_translation.dart';
import 'package:movie_app/views/detail_movie/detail_movie_screen.dart';
import 'package:movie_app/views/list_movie/list_movie_screen.dart';

class FindMovieScreen extends StatefulWidget {
  const FindMovieScreen({super.key});

  @override
  State<FindMovieScreen> createState() => _FindMovieScreenState();
}

class _FindMovieScreenState extends State<FindMovieScreen> {
  final TextEditingController findController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 14),
                child: TextFormField(
                  controller: findController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: LanguageTranslation.of(context)!
                        .value('enter-movie-title'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  onChanged: (value) {
                    if (value != "") {
                      context
                          .read<MovieBloc>()
                          .add(GetMovieByTitle(title: value));
                    }
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<MovieBloc, MovieState>(
                  buildWhen: (previous, current) =>
                      previous != current && current is SuccessMovieByTitle,
                  builder: (context, state) {
                    if (state is SuccessMovieByTitle) {
                      MovieResponseModel result = state.result;
                      return GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Jumlah kolom
                          crossAxisSpacing: 8.0, // Jarak antar kolom
                          mainAxisSpacing: 28.0, // Jarak antar baris
                          // childAspectRatio: 1, //
                          mainAxisExtent: 200.0,
                        ),
                        itemCount: result.search.length, // Jumlah item
                        itemBuilder: (BuildContext context, int index) {
                          Search data = result.search[index];
                          // Item builder, misalnya sebuah Container sebagai contoh
                          return InkWell(
                              onTap: () {
                                context
                                    .read<MovieBloc>()
                                    .add(GetMovieDetail(idMovie: data.imdbId));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailMovieScreen(),
                                    ));
                              },
                              child: MovieGeneralWidget(
                                dataMovie: data,
                                showFavoriteIcon: false,
                              ));
                        },
                      );
                    }
                    return Center(
                      child: Text(
                          LanguageTranslation.of(context)!.value('no-data')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
