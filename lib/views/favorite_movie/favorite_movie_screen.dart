import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:movie_app/models/responses/movie_detail_response_model.dart';
import 'package:movie_app/services/language_translation.dart';
import 'package:movie_app/shared/colors_app.dart';

class FavoriteMovieScreen extends StatefulWidget {
  const FavoriteMovieScreen({super.key});

  @override
  State<FavoriteMovieScreen> createState() => _FavoriteMovieScreenState();
}

class _FavoriteMovieScreenState extends State<FavoriteMovieScreen> {
  List<MovieDetailResponseModel> datas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LanguageTranslation.of(context)!.value('favorite-movie')),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is LoadingGetAllFavorite) {
            return Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is SuccessGetAllFavorite) {
            datas = state.result;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: datas.length,
              itemBuilder: (context, index) {
                MovieDetailResponseModel data = datas[index];
                return Container(
                  margin: EdgeInsets.all(4),
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorsApp.orangeMtix.withOpacity(.8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        height: MediaQuery.sizeOf(context).height / 6,
                        width: MediaQuery.sizeOf(context).width / 3.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: (data.poster != "N/A")
                                ? data.poster
                                : "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.title),
                              SizedBox(height: 8),
                              Text("${data.released}"),
                              SizedBox(height: 8),
                              Text(data.genre),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.sizeOf(context).width / 10,
                            MediaQuery.sizeOf(context).width / 10,
                          ),
                          shape: const CircleBorder(),
                          backgroundColor: Colors.grey.shade300.withOpacity(.6),
                          padding: EdgeInsets.zero,
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: MediaQuery.sizeOf(context).width / 14,
                        ),
                        onPressed: () {
                          context.read<MovieBloc>().add(SetFavoriteMovieEvent(
                              movieId: data.imdbId, status: false));

                          context.read<MovieBloc>().add(GetAllFavoriteEvent());
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
