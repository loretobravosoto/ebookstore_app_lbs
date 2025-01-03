part of 'ebookstore_bloc.dart';

abstract class EbookstoreEvent extends Equatable {
  const EbookstoreEvent();

  @override
  List<Object> get props => [];
}

class LoadBooksEvent extends EbookstoreEvent {}

class LoadCartEvent extends EbookstoreEvent {}

class LoadBookmarksEvent extends EbookstoreEvent {}

class CreateNewBookEvent extends EbookstoreEvent {
  final String id;
  final String title;
  final String author;
  final double price;
  final double rate;
  final int pages;
  final String imageUrl;
  final String language;
  final String description;

  const CreateNewBookEvent({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.rate,
    required this.pages,
    required this.imageUrl,
    required this.language,
    required this.description,
  });

  @override
  List<Object> get props =>
      [id, title, author, price, rate, pages, imageUrl, language, description];
}

class DeleteBookEvent extends EbookstoreEvent {
  final BookModel book;

  const DeleteBookEvent({required this.book});

  @override
  List<Object> get props => [book];
}

class DeleteCartBookEvent extends EbookstoreEvent {
  final BookModel book;

  const DeleteCartBookEvent({required this.book});

  @override
  List<Object> get props => [book];
}

class AddToCartEvent extends EbookstoreEvent {
  final BookModel book;
  final int quantity;

  const AddToCartEvent({required this.book, required this.quantity});

  @override
  List<Object> get props => [book, quantity];
}

class ToggleBookmarkEvent extends EbookstoreEvent {
  final BookmarkModel book;

  const ToggleBookmarkEvent({required this.book});

  @override
  List<Object> get props => [book];
}

class CheckoutCartEvent extends EbookstoreEvent {
  const CheckoutCartEvent();
}

class LoadReadingEvent extends EbookstoreEvent {
  const LoadReadingEvent();
}

class StartReadingEvent extends EbookstoreEvent {
  final ReadingModel book;

  const StartReadingEvent({required this.book});

  @override
  List<Object> get props => [book];
}
