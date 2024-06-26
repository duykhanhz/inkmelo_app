import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkmelo_app/blocs/genre/genre_bloc.dart';
import 'package:inkmelo_app/blocs/genre/genre_state.dart';
import 'package:inkmelo_app/config/colors.dart';
import 'package:inkmelo_app/presentations/screens/book_detail/book_detail_page.dart';
import 'package:inkmelo_app/presentations/screens/cart/cart_page.dart';
import 'package:inkmelo_app/presentations/widgets/book_card.dart';

import '../../../blocs/book/book_bloc.dart';
// import '../../../blocs/category/category_bloc.dart';
import 'app_bar.dart';
import 'category_widget.dart';
import 'my_input_text_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const String routeName = '/home-page';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const HomePage(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        width: 52.5,
        height: 52.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 186, 186, 186).withOpacity(0.35),
              spreadRadius: 8,
              blurRadius: 8,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        margin: const EdgeInsets.only(top: 10),
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: primaryColor,
            elevation: 5,
            shape: const CircleBorder(),
            onPressed: () async {
              Navigator.pushNamed(context, CartPage.routeName);
            },
            child: const Center(
                child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
              size: 30,
            )),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              color: primaryColor,
              // height: 500,
              child: Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          const HomeAppBar(),
                          const SizedBox(height: 50),
                          Row(
                            children: [
                              Text(
                                "Hello ✌️",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          // ignore: deprecated_member_use
                                          .background,
                                    ),
                              ),
                              Text(
                                "Khanh",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "Time to read book and enhance your knowledge",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const MyInputTextField(),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Topics",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          // ignore: deprecated_member_use
                                          .background,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          BlocBuilder<GenreBloc, GenreState>(
                            builder: (context, state) {
                              if (state is GenreLoaded) {
                                return SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.genres.length,
                                    itemBuilder: (context, index) {
                                      return CategoryWidget(
                                          btnName: state.genres[index].name);
                                    },
                                  ),
                                );
                              } else if (state is GenreLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                );
                              }
                              return const SizedBox(
                                child: Text('Error!'),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Trending",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<BookBloc, BookState>(
                    builder: (context, state) {
                      if (state is BookLoaded) {
                        return SizedBox(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.books.length,
                            itemBuilder: (context, index) {
                              var book = state.books[index];
                              return BookCard(
                                title: book.title,
                                coverUrl: 'assets/images/boundraries.jpg',
                                ontap: () {
                                  Navigator.pushNamed(
                                      context, BookDetailsPage.routeName,
                                      arguments: book);
                                },
                              );
                            },
                          ),
                        );
                      } else if (state is BookLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        );
                      }
                      return const SizedBox(
                        child: Text('Error!'),
                      );
                    },
                  )
                  // SizedBox(height: 10),
                  // Row(
                  //   children: [
                  //     Text(
                  //       "Your Interests",
                  //       style: Theme.of(context).textTheme.labelMedium,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 10),
                  // Column(
                  //     children: bookData
                  //         .map(
                  //           (e) => BookTile(
                  //           title: e.title!,
                  //           coverUrl: e.coverUrl!,
                  //           author: e.author!,
                  //           price: e.price!,
                  //           rating: e.rating!,
                  //           totalRating: 12),
                  //     )
                  //         .toList())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
