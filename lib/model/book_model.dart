import 'package:equatable/equatable.dart';

class BookModel extends Equatable {
  final String id;
  final String title;
  final String author;
  final double price;
  final double rate;
  final int pages;
  final String imageUrl;
  final int quantity;
  final String language;
  final String description;

  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.rate,
    required this.pages,
    required this.imageUrl,
    this.quantity = 1,
    required this.language,
    required this.description,
  });

  BookModel copyWith({
    String? id,
    String? title,
    String? author,
    double? price,
    double? rate,
    int? pages,
    String? imageUrl,
    int? quantity,
    String? language,
    String? description,
  }) {
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      price: price ?? this.price,
      rate: rate ?? this.rate,
      pages: pages ?? this.pages,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      language: language ?? this.language,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        author,
        price,
        rate,
        pages,
        imageUrl,
        quantity,
        language,
        description,
      ];
}
