import 'package:ebookstore_app/bloc/ebookstore_bloc.dart';
import 'package:ebookstore_app/model/book_model.dart';
import 'package:ebookstore_app/pages/add_book_page.dart';
import 'package:ebookstore_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaintainerPage extends StatelessWidget {
  const MaintainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<EbookstoreBloc>()..add(LoadBooksEvent()),
      child: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Books Catalog",
          style: TextStyle(
            fontSize: 16,
            color: AppColor.greyLight,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddBookPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: AppColor.white,
      body: BlocBuilder<EbookstoreBloc, EbookstoreState>(
        builder: (context, state) {
          if (state.bookScreenState == BookScreenState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.books.isEmpty) {
            return const Center(
              child: Text(
                "No books available.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            itemCount: state.books.length,
            itemBuilder: (context, index) {
              final book = state.books[index];
              return ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBookPage(
                      bookModel: book,
                      isEditMode: true,
                    ),
                  ),
                ),
                title: Text(
                  book.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  "\$${book.price.toStringAsFixed(2)} - ${book.author}",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColor.greyLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Image.network(
                  book.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                leading: IconButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, book);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: AppColor.red,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void _showDeleteConfirmationDialog(BuildContext context, BookModel book) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this book?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(); 
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(); 
              context.read<EbookstoreBloc>().add(
                    DeleteBookEvent(book: book),
                  );

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Book deleted successfully."),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.orange,
            ),
            child:  Text("Delete", style: TextStyle(color: AppColor.white),),
          ),
        ],
      );
    },
  );
}
