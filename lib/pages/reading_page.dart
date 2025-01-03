import 'package:ebookstore_app/pages/main_page.dart';
import 'package:ebookstore_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/ebookstore_bloc.dart';
import '../model/reading_model.dart';

class ReadingPage extends StatelessWidget {
  const ReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<EbookstoreBloc>().add(const LoadReadingEvent());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        title: Text(
          "Reading list",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.greyLight),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColor.white,
      body: BlocBuilder<EbookstoreBloc, EbookstoreState>(
        builder: (context, state) {
          if (state.readingScreenState == ReadingScreenState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.reading.isEmpty) {
            return const Center(
              child: Text("No books in reading list."),
            );
          }

          return ListView.builder(
            itemCount: state.reading.length,
            itemBuilder: (context, index) {
              final book = state.reading[index];
              return _buildReadingItem(context, book);
            },
          );
        },
      ),
    );
  }

  Widget _buildReadingItem(BuildContext context, ReadingModel book) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.green,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.greyBackground,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              book.imageUrl,
              width: 50,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "By ${book.author}",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColor.greyLight,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: book.status == "pending"
                ? () {
                    context
                        .read<EbookstoreBloc>()
                        .add(StartReadingEvent(book: book));
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                      (route) => false,
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: book.status == "pending"
                  ? AppColor.orange
                  : AppColor.greyLight,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              book.status == "pending" ? "Start reading" : "Reading",
              style: TextStyle(
                fontSize: 12,
                color: book.status == "pending"
                    ? AppColor.white
                    : AppColor.greyLight,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
