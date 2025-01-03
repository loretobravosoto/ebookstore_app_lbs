import 'package:ebookstore_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:ebookstore_app/bloc/ebookstore_bloc.dart';
import 'package:ebookstore_app/pages/book_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebookstore_app/model/book_model.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "More Books",
          style: TextStyle(
            fontSize: 16,
            color: AppColor.greyLight,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back,
          color: AppColor.greyLight),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon:  Icon(Icons.more_horiz,
            color: AppColor.greyLight),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<EbookstoreBloc, EbookstoreState>(
          builder: (context, state) {
            if (state.bookScreenState == BookScreenState.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.books.isEmpty) {
              return const Center(
                child: Text("No books available."),
              );
            }

            return GridView.builder(
              itemCount: state.books.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 30, 
                mainAxisSpacing: 12, 
                childAspectRatio: 0.65, 
              ),
              itemBuilder: (context, index) {
                final book = state.books[index];
                return _buildCardBook(context, book, screenWidth);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCardBook(
      BuildContext context, BookModel book, double screenWidth) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(book: book),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: screenWidth * 0.5, 
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                book.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported, size: 50);
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              book.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColor.greyLight,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Flexible(
            child: Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColor.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
