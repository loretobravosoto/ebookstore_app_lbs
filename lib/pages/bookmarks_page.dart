import 'package:ebookstore_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebookstore_app/bloc/ebookstore_bloc.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        title: Text(
          "Bookmarks",
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
          if (state.bookmarkScreenState == BookmarkScreenState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.bookmarks.isEmpty) {
            return const Center(
              child: Text("No bookmarks available."),
            );
          }

          return ListView.builder(
            itemCount: state.bookmarks.length,
            itemBuilder: (context, index) {
              final book = state.bookmarks[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    book.imageUrl,
                    width: 50,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_not_supported,
                      size: 50,
                    ),
                  ),
                ),
                title: Text(
                  book.title,
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  "By ${book.author}",
                  style: TextStyle(
                    color: AppColor.greyLight,
                    fontSize: 12,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.bookmark),
                  color: AppColor.green,
                  onPressed: () {
                    context.read<EbookstoreBloc>().add(
                          ToggleBookmarkEvent(book: book),
                        );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
