import 'package:equatable/equatable.dart';

class BookmarkModel extends Equatable {
  final String id;
  final String title;
  final String author;
  final String imageUrl;

  const BookmarkModel({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
  });

  BookmarkModel copyWith({
    String? id,
    String? title,
    String? author,
    String? imageUrl,
  }) {
    return BookmarkModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        author,
        imageUrl,
      ];
}
