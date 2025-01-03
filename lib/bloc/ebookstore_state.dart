part of 'ebookstore_bloc.dart';

enum BookScreenState { none, loading, success, failure }

enum CartScreenState { none, loading, success, failure }

enum BookmarkScreenState { none, loading, success, failure }

enum ReadingScreenState { none, loading, success, failure }

class EbookstoreState extends Equatable {
  final List<BookModel> books;
  final List<BookModel> cart;
  final List<BookmarkModel> bookmarks;
  final List<ReadingModel> reading;
  final BookScreenState bookScreenState;
  final CartScreenState cartScreenState;
  final BookmarkScreenState bookmarkScreenState;
  final ReadingScreenState readingScreenState;

  const EbookstoreState({
    required this.books,
    required this.cart,
    required this.bookmarks,
    required this.reading,
    required this.bookScreenState,
    required this.cartScreenState,
    required this.bookmarkScreenState,
    required this.readingScreenState,
  });

  factory EbookstoreState.initial() {
    return const EbookstoreState(
      books: [],
      cart: [],
      bookmarks: [],
      reading: [],
      bookScreenState: BookScreenState.none,
      cartScreenState: CartScreenState.none,
      bookmarkScreenState: BookmarkScreenState.none,
      readingScreenState: ReadingScreenState.none,
    );
  }

  EbookstoreState copyWith({
    List<BookModel>? books,
    List<BookModel>? cart,
    List<BookmarkModel>? bookmarks,
    List<ReadingModel>? reading,
    BookScreenState? bookScreenState,
    CartScreenState? cartScreenState,
    BookmarkScreenState? bookmarkScreenState,
    ReadingScreenState? readingScreenState,
  }) {
    return EbookstoreState(
      books: books ?? this.books,
      cart: cart ?? this.cart,
      bookmarks: bookmarks ?? this.bookmarks,
      reading: reading ?? this.reading,
      bookScreenState: bookScreenState ?? this.bookScreenState,
      cartScreenState: cartScreenState ?? this.cartScreenState,
      bookmarkScreenState: bookmarkScreenState ?? this.bookmarkScreenState,
      readingScreenState: readingScreenState ?? this.readingScreenState,
    );
  }

  @override
  List<Object?> get props => [
        books,
        cart,
        bookmarks,
        reading,
        bookScreenState,
        cartScreenState,
        bookmarkScreenState,
        readingScreenState,
      ];
}
