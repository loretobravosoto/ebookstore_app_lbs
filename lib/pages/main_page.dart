import 'package:ebookstore_app/pages/book_detail_page.dart';
import 'package:ebookstore_app/pages/bookmarks_page.dart';
import 'package:ebookstore_app/pages/books_page.dart';
import 'package:ebookstore_app/pages/cart_page.dart';
import 'package:ebookstore_app/pages/maintainer_page.dart';
import 'package:ebookstore_app/pages/reading_page.dart';
import 'package:ebookstore_app/widgets/app_colors.dart';
import 'package:ebookstore_app/widgets/continue_reading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../bloc/ebookstore_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const MainPageContent(),
    const ReadingPage(),
    const BookmarksPage(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<EbookstoreBloc>()
      ..add(LoadBooksEvent())
      ..add(LoadCartEvent())
      ..add(LoadBookmarksEvent())
      ..add(const LoadReadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColor.green,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedItemColor: AppColor.orange,
            unselectedItemColor: AppColor.greyLight,
            backgroundColor: AppColor.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                label: "Explore",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined),
                label: "Reading",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_outline),
                label: "Bookmark",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainPageContent extends StatelessWidget {
  const MainPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MaintainerPage()),
            );
          },
          icon: Icon(
            Icons.apps,
            color: AppColor.greyLight,
            size: 28,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColor.greyLight,
                  size: 28,
                ),
              ),
              BlocBuilder<EbookstoreBloc, EbookstoreState>(
                builder: (context, state) {
                  final totalQuantity = state.cart.fold<int>(
                    0,
                    (sum, book) => sum + book.quantity,
                  );

                  if (totalQuantity > 0) {
                    return Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColor.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$totalQuantity',
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/img/profile.jpg'),
            ),
          ),
        ],
      ),
      body: Container(
        color: AppColor.white,
        child: SingleChildScrollView(
          child: BlocBuilder<EbookstoreBloc, EbookstoreState>(
            builder: (context, state) {
              if (state.bookScreenState == BookScreenState.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.greyBackground,
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColor.greyLight,
                        ),
                        suffixIcon: Icon(
                          Icons.mic,
                          color: AppColor.greyLight,
                        ),
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: AppColor.greyLight,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Trending Book",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColor.greyLight)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BooksPage()),
                            );
                          },
                          child: Text(
                            "See more",
                            style: TextStyle(color: AppColor.greyLight),
                          ),
                        ),
                      ],
                    ),
                  ),
                  state.books.isEmpty
                      ? SizedBox(
                          height:
                              230.0, 
                          child: Center(
                            child: Text(
                              "No books available.",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.greyLight,
                              ),
                            ),
                          ),
                        )
                      : CarouselSlider(
                          options: CarouselOptions(
                            height: 230.0,
                            viewportFraction: 0.35,
                            autoPlay: false,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            autoPlayCurve: Curves.easeInOut,
                            padEnds: false,
                          ),
                          // Acá se ordena por mayor a menor rate del listado de book de firebase
                          items: (state.books.toList()
                                ..sort((a, b) => b.rate.compareTo(a.rate)))
                              .take(5)
                              .map((book) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BookDetailPage(book: book),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 140.0,
                                    width: 120.0,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: NetworkImage(book.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "by ${book.author}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.greyLight,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: 100.0,
                                    child: Text(
                                      book.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 14,
                                        color: AppColor.orange,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        book.rate.toStringAsFixed(1),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.greyLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 8,
                  ),
                  const ContinueReadingWidget(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
