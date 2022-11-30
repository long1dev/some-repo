import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const MoviesPage(),
    );
  }
}

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  final ScrollController _controller = ScrollController();
  final List<Movie> _movies = <Movie>[];
  int _page = 1;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getMovies();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final double offset = _controller.offset;
    final double maxScrollExtent = _controller.position.maxScrollExtent;

    if (offset > maxScrollExtent - MediaQuery.of(context).size.height && !_isLoading) {
      _getMovies();
    }
  }

  Future<void> _getMovies() async {
    setState(() => _isLoading = true);

    final Response response = await get(Uri.parse('https://yts.mx/api/v2/list_movies.json?limit=20&page=$_page'));
    final Map<String, dynamic> map = jsonDecode(response.body) as Map<String, dynamic>;
    final Map<String, dynamic> data = map['data'] as Map<String, dynamic>;
    final List<Map<dynamic, dynamic>> movies = List<Map<dynamic, dynamic>>.from(data['movies'] as List<dynamic>);

    _movies.addAll(movies.map((Map<dynamic, dynamic> item) => Movie.fromJson(item)));
    _page = _page + 1;

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: SafeArea(
        child: Builder(
          builder: (BuildContext context) {
            if (_isLoading && _page == 1) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              controller: _controller,
              itemCount: _movies.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (_movies.length == index) {
                  if (_isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }

                final Movie movie = _movies[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: NetworkImage(movie.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * .6,
                            height: 110,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  movie.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  '${movie.year}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class Movie {
  const Movie(this.title, this.image, this.year);

  Movie.fromJson(Map<dynamic, dynamic> item)
      : title = item['title'] as String,
        image = item['medium_cover_image'] as String,
        year = item['year'] as int;

  final String title;
  final String image;
  final int year;
}
