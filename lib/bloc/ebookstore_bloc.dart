import 'dart:math';
import 'package:dio/dio.dart';
import 'package:ebookstore_app/model/book_model.dart';
import 'package:ebookstore_app/model/bookmark_model.dart';
import 'package:ebookstore_app/model/reading_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'ebookstore_event.dart';
part 'ebookstore_state.dart';

const booksUrl =
    "https://ebook-store-app-1df29-default-rtdb.firebaseio.com/books";
const cartUrl =
    "https://ebook-store-app-1df29-default-rtdb.firebaseio.com/cart";

const bookmarksUrl =
    "https://ebook-store-app-1df29-default-rtdb.firebaseio.com/bookmarks";

const readingUrl =
    "https://ebook-store-app-1df29-default-rtdb.firebaseio.com/reading";

class EbookstoreBloc extends Bloc<EbookstoreEvent, EbookstoreState> {
  final dio = Dio();
  final uuid = Uuid();

  EbookstoreBloc() : super(EbookstoreState.initial()) {
    on<LoadBooksEvent>(_onLoadBooksEvent);
    on<CreateNewBookEvent>(_onCreateNewBookEvent);
    on<DeleteBookEvent>(_onDeleteBookEvent);
    on<LoadCartEvent>(_onLoadCartEvent);
    on<AddToCartEvent>(_onAddToCartEvent);
    on<DeleteCartBookEvent>(_onDeleteCartBookEvent);
    on<LoadBookmarksEvent>(_onLoadBookmarksEvent);
    on<ToggleBookmarkEvent>(_onToggleBookmarkEvent);
    on<CheckoutCartEvent>(_onCheckoutCartEvent);
    on<LoadReadingEvent>(_onLoadReadingEvent);
    on<StartReadingEvent>(_onStartReadingEvent);
  }

  void _onLoadBooksEvent(
      LoadBooksEvent event, Emitter<EbookstoreState> emit) async {
    emit(state.copyWith(bookScreenState: BookScreenState.loading));

    try {
      final response = await dio.get('$booksUrl.json');
      final data = response.data as Map<String, dynamic>?;

      if (data == null) {
        emit(state
            .copyWith(bookScreenState: BookScreenState.success, books: []));
        return;
      }

      final books = data.entries.map((book) {
        return BookModel(
          id: book.key,
          title: book.value["title"],
          author: book.value["author"],
          price: double.parse(book.value["price"].toString()),
          rate: double.parse(book.value["rate"].toString()),
          pages: int.parse(book.value["pages"].toString()),
          imageUrl: book.value["imageUrl"],
          language: book.value["language"],
          description: book.value["description"],
        );
      }).toList();

      emit(state.copyWith(
          bookScreenState: BookScreenState.success, books: books));
    } catch (e) {
      emit(state.copyWith(bookScreenState: BookScreenState.failure));
    }
  }

  void _onCreateNewBookEvent(
      CreateNewBookEvent event, Emitter<EbookstoreState> emit) async {
    final String bookId = event.id.isEmpty ? uuid.v1() : event.id;

    final data = {
      "id": bookId,
      "title": event.title,
      "author": event.author,
      "price": event.price,
      "rate": event.rate,
      "pages": event.pages,
      "imageUrl": event.imageUrl,
      "language": event.language,
      "description": event.description,
    };

    await dio.put("$booksUrl/$bookId.json", data: data);

    if (event.id.isEmpty) {
      final newBook = BookModel(
        id: bookId,
        title: event.title,
        author: event.author,
        price: event.price,
        rate: event.rate,
        pages: event.pages,
        imageUrl: event.imageUrl,
        language: event.language,
        description: event.description,
      );
      emit(state.copyWith(books: [...state.books, newBook]));
    } else {
      final updatedBooks = state.books.map((book) {
        if (book.id == bookId) {
          return book.copyWith(
            title: event.title,
            author: event.author,
            price: event.price,
            rate: event.rate,
            pages: event.pages,
            imageUrl: event.imageUrl,
            language: event.language,
            description: event.description,
          );
        }
        return book;
      }).toList();

      emit(state.copyWith(books: updatedBooks));
    }
  }

  void _onDeleteBookEvent(
      DeleteBookEvent event, Emitter<EbookstoreState> emit) async {
    await dio.delete("$booksUrl/${event.book.id}.json");

    final updatedBooks =
        state.books.where((book) => book.id != event.book.id).toList();

    emit(state.copyWith(books: updatedBooks));
  }

  void _onAddToCartEvent(
      AddToCartEvent event, Emitter<EbookstoreState> emit) async {
    final existingBookIndex =
        state.cart.indexWhere((b) => b.id == event.book.id);
    final updatedCart = List<BookModel>.from(state.cart);

    try {
      if (existingBookIndex != -1) {
        final existingBook = updatedCart[existingBookIndex];
        final updatedQuantity = event.quantity;
        final updatedBook = existingBook.copyWith(quantity: updatedQuantity);

        await dio.put(
          "$cartUrl/${event.book.id}.json",
          data: {
            "id": updatedBook.id,
            "title": updatedBook.title,
            "author": updatedBook.author,
            "price": updatedBook.price,
            "rate": updatedBook.rate,
            "pages": updatedBook.pages,
            "imageUrl": updatedBook.imageUrl,
            "quantity": updatedQuantity,
            "language": updatedBook.language,
            "description": updatedBook.description,
          },
        );

        updatedCart[existingBookIndex] = updatedBook;
      } else {
        final newBook = event.book.copyWith(quantity: event.quantity);
        await dio.put(
          "$cartUrl/${newBook.id}.json",
          data: {
            "id": newBook.id,
            "title": newBook.title,
            "author": newBook.author,
            "price": newBook.price,
            "rate": newBook.rate,
            "pages": newBook.pages,
            "imageUrl": newBook.imageUrl,
            "quantity": newBook.quantity,
            "language": newBook.language,
            "description": newBook.description,
          },
        );

        updatedCart.add(newBook);
      }

      emit(state.copyWith(cart: updatedCart));
    } catch (e) {
      emit(state.copyWith(cartScreenState: CartScreenState.failure));
    }
  }

  void _onLoadCartEvent(
      LoadCartEvent event, Emitter<EbookstoreState> emit) async {
    emit(state.copyWith(cartScreenState: CartScreenState.loading));

    try {
      final response = await dio.get('$cartUrl.json');
      final data = response.data as Map<String, dynamic>?;

      if (data == null) {
        emit(
            state.copyWith(cartScreenState: CartScreenState.success, cart: []));
        return;
      }

      final cartBooks = data.entries.map((entry) {
        final book = entry.value;
        return BookModel(
          id: book["id"],
          title: book["title"],
          author: book["author"],
          price: book["price"],
          rate: book["rate"],
          pages: book["pages"],
          imageUrl: book["imageUrl"],
          quantity: book["quantity"],
          language: book["language"],
          description: book["description"],
        );
      }).toList();

      emit(state.copyWith(
          cartScreenState: CartScreenState.success, cart: cartBooks));
    } catch (e) {
      emit(state.copyWith(cartScreenState: CartScreenState.failure));
    }
  }

  void _onDeleteCartBookEvent(
      DeleteCartBookEvent event, Emitter<EbookstoreState> emit) async {
    try {
      await dio.delete("$cartUrl/${event.book.id}.json");

      final updatedCart =
          state.cart.where((book) => book.id != event.book.id).toList();

      emit(state.copyWith(cart: updatedCart));
    } catch (e) {
      emit(state.copyWith(cartScreenState: CartScreenState.failure));
    }
  }

  void _onToggleBookmarkEvent(
      ToggleBookmarkEvent event, Emitter<EbookstoreState> emit) async {
    try {
      final bookmark = event.book;
      final isBookmarked = state.bookmarks.any((b) => b.id == bookmark.id);

      if (isBookmarked) {
        await dio.delete('$bookmarksUrl/${bookmark.id}.json');
        final updatedBookmarks =
            state.bookmarks.where((b) => b.id != bookmark.id).toList();
        emit(state.copyWith(bookmarks: updatedBookmarks));
      } else {
        await dio.put('$bookmarksUrl/${bookmark.id}.json', data: {
          "id": bookmark.id,
          "title": bookmark.title,
          "author": bookmark.author,
          "imageUrl": bookmark.imageUrl,
        });

        emit(state.copyWith(bookmarks: [...state.bookmarks, bookmark]));
      }
    } catch (e) {
      emit(state.copyWith(bookmarkScreenState: BookmarkScreenState.failure));
    }
  }

  void _onLoadBookmarksEvent(
      LoadBookmarksEvent event, Emitter<EbookstoreState> emit) async {
    emit(state.copyWith(bookmarkScreenState: BookmarkScreenState.loading));

    try {
      final response = await dio.get('$bookmarksUrl.json');
      final data = response.data as Map<String, dynamic>?;

      if (data == null || data.isEmpty) {
        emit(state.copyWith(
          bookmarkScreenState: BookmarkScreenState.success,
          bookmarks: [],
        ));
        return;
      }

      final bookmarks = data.entries.map((entry) {
        final book = entry.value;
        return BookmarkModel(
          id: book["id"],
          title: book["title"],
          author: book["author"],
          imageUrl: book["imageUrl"],
        );
      }).toList();

      emit(state.copyWith(
        bookmarkScreenState: BookmarkScreenState.success,
        bookmarks: bookmarks,
      ));
    } catch (e) {
      emit(state.copyWith(bookmarkScreenState: BookmarkScreenState.failure));
    }
  }

  void _onCheckoutCartEvent(
      CheckoutCartEvent event, Emitter<EbookstoreState> emit) async {
    final cartBooks = state.cart;

    try {
      for (final book in cartBooks) {
        await dio.put('$readingUrl/${book.id}.json', data: {
          "id": book.id,
          "title": book.title,
          "author": book.author,
          "pages": book.pages,
          "imageUrl": book.imageUrl,
          "status": "pending",
        });
      }

      for (final book in cartBooks) {
        await dio.delete('$cartUrl/${book.id}.json');
      }

      emit(state.copyWith(cart: []));
    } catch (e) {
      emit(state.copyWith(cartScreenState: CartScreenState.failure));
    }
  }

  void _onLoadReadingEvent(
      LoadReadingEvent event, Emitter<EbookstoreState> emit) async {
    emit(state.copyWith(readingScreenState: ReadingScreenState.loading));

    try {
      final response = await dio.get('$readingUrl.json');
      final data = response.data as Map<String, dynamic>?;

      if (data == null || data.isEmpty) {
        emit(state.copyWith(
          readingScreenState: ReadingScreenState.success,
          reading: [],
        ));
        return;
      }

      final readingBooks = data.entries.map((entry) {
        final book = entry.value as Map<String, dynamic>;
        return ReadingModel(
          id: book["id"] as String,
          title: book["title"] as String,
          author: book["author"] as String,
          pages: book["pages"] as int,
          imageUrl: book["imageUrl"] as String,
          status: book["status"] as String?,
          progress: book["progress"] as int?,
          timestamp: book["timestamp"] != null
              ? DateTime.parse(book["timestamp"] as String)
              : null,
        );
      }).toList();

      emit(state.copyWith(
        readingScreenState: ReadingScreenState.success,
        reading: readingBooks,
      ));
    } catch (e) {
      emit(state.copyWith(readingScreenState: ReadingScreenState.failure));
    }
  }

  void _onStartReadingEvent(
      StartReadingEvent event, Emitter<EbookstoreState> emit) async {
    final book = event.book;

    try {
      // Acá se genera el mock de en que página va la lectura
      final random = Random();
      final progress = book.progress ?? (random.nextInt(book.pages) + 1);

      await dio.put('$readingUrl/${book.id}.json', data: {
        "id": book.id,
        "title": book.title,
        "author": book.author,
        "pages": book.pages,
        "imageUrl": book.imageUrl,
        "status": "reading",
        "progress": progress,
        "timestamp": book.timestamp?.toIso8601String() ??
            DateTime.now().toIso8601String(),
      });

      final updatedReading = state.reading.map((b) {
        if (b.id == book.id) {
          return b.copyWith(
            status: "reading",
            progress: progress,
            timestamp: book.timestamp ?? DateTime.now(),
          );
        }
        return b;
      }).toList();

      if (!updatedReading.any((b) => b.id == book.id)) {
        updatedReading.add(ReadingModel(
          id: book.id,
          title: book.title,
          author: book.author,
          pages: book.pages,
          imageUrl: book.imageUrl,
          status: "reading",
          progress: progress,
          timestamp: DateTime.now(),
        ));
      }

      emit(state.copyWith(reading: updatedReading));
    } catch (e) {
      emit(state.copyWith(readingScreenState: ReadingScreenState.failure));
    }
  }
}
