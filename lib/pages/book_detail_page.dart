import 'package:ebookstore_app/model/bookmark_model.dart';
import 'package:ebookstore_app/pages/main_page.dart';
import 'package:ebookstore_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebookstore_app/model/book_model.dart';
import 'package:ebookstore_app/bloc/ebookstore_bloc.dart';

class BookDetailPage extends StatefulWidget {
  final BookModel book;

  const BookDetailPage({super.key, required this.book});

  @override
  BookDetailPageState createState() => BookDetailPageState();
}

class BookDetailPageState extends State<BookDetailPage> {
  int _quantity = 1;

  @override
  void initState() {
    super.initState();

    final cart = context.read<EbookstoreBloc>().state.cart;
    final existingBook = cart.firstWhere(
      (book) => book.id == widget.book.id,
      orElse: () => widget.book.copyWith(quantity: 1),
    );

    setState(() {
      _quantity = existingBook.quantity;
    });
  }

  void _increaseQuantity() {
    if (_quantity < 5) {
      setState(() {
        _quantity++;
      });
    }
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.greyBackground,
        title: Text(
          "Detail Book",
          style: TextStyle(
            fontSize: 16,
            color: AppColor.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.greyLight),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: AppColor.greyLight),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: AppColor.greyBackground,
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.3,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: screenHeight * 0.4,
                    width: screenWidth * 0.32,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.book.imageUrl,
                      height: screenHeight * 0.28,
                      width: screenWidth * 0.3,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported, size: 100);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.greyBackground,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${widget.book.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.green,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          final bookmark = BookmarkModel(
                            id: widget.book.id,
                            title: widget.book.title,
                            author: widget.book.author,
                            imageUrl: widget.book.imageUrl,
                          );
                          context.read<EbookstoreBloc>().add(
                                ToggleBookmarkEvent(book: bookmark),
                              );
                        },
                        icon: BlocBuilder<EbookstoreBloc, EbookstoreState>(
                          builder: (context, state) {
                            final isBookmarked = state.bookmarks
                                .any((b) => b.id == widget.book.id);
                            return Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: AppColor.green,
                              size: 24,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.book.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "By ${widget.book.author}",
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColor.greyLight,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColor.greyBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInfo("Rating", widget.book.rate.toString()),
                        _buildInfo(
                            "Number of pages", "${widget.book.pages} Pages"),
                        _buildInfo("Language", widget.book.language),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Text(
                      widget.book.description,
                      style: TextStyle(fontSize: 12, color: AppColor.greyLight),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColor.greyBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "QTY",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColor.greyLight,
                              ),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              onPressed: _decreaseQuantity,
                              icon: const Icon(Icons.remove),
                              splashRadius: 20,
                              iconSize: 12,
                              color: AppColor.black,
                            ),
                            Text(
                              "$_quantity",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColor.green,
                              ),
                            ),
                            IconButton(
                              onPressed: _increaseQuantity,
                              icon: const Icon(Icons.add),
                              splashRadius: 20,
                              iconSize: 12,
                              color: AppColor.black,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<EbookstoreBloc>().add(
                                AddToCartEvent(
                                  book: widget.book,
                                  quantity: _quantity,
                                ),
                              );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("${widget.book.title} added to cart!"),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.orange,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: AppColor.greyLight,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
