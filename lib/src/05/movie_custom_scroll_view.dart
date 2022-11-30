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
  final List<String> _titles = <String>[];
  final List<String> _images = <String>[];
  final List<int> _years = <int>[];
  int _page = 1;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getMovies();
  }

  Future<void> _getMovies() async {
    setState(() => _isLoading = true);

    final Response response = await get(Uri.parse('https://yts.mx/api/v2/list_movies.json?limit=20&page=$_page'));
    final Map<String, dynamic> map = jsonDecode(response.body) as Map<String, dynamic>;
    final Map<String, dynamic> data = map['data'] as Map<String, dynamic>;
    final List<Map<dynamic, dynamic>> movies = List<Map<dynamic, dynamic>>.from(data['movies'] as List<dynamic>);

    for (final Map<dynamic, dynamic> item in movies) {
      _titles.add(item['title'] as String);
      _images.add(item['medium_cover_image'] as String);
      _years.add(item['year'] as int);
    }
    _page = _page + 1;

    setState(() => _isLoading = false);
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

            return CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final String title = _titles[index];
                      final String image = _images[index];
                      final int year = _years[index];

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
                                    image: NetworkImage(image),
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
                                        title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        '$year',
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
                    childCount: _titles.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Builder(
                    builder: (BuildContext context) {
                      if (_isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Center(
                          child: ElevatedButton(
                            child: const Text('Load more'),
                            onPressed: () {
                              _getMovies();
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
