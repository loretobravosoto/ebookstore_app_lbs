import 'package:equatable/equatable.dart';

class ReadingModel extends Equatable {
  final String id;
  final String title;
  final String author;
  final int pages;
  final String imageUrl;
  final String? status;
  final DateTime? timestamp;
  final int? progress;

  const ReadingModel({
    required this.id,
    required this.title,
    required this.author,
    required this.pages,
    required this.imageUrl,
    this.status,
    this.timestamp,
    this.progress,
  });

  ReadingModel copyWith({
    String? id,
    String? title,
    String? author,
    int? pages,
    String? imageUrl,
    String? status,
    DateTime? timestamp,
    int? progress,
  }) {
    return ReadingModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      pages: pages ?? this.pages,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      progress: progress ?? this.progress,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        author,
        pages,
        imageUrl,
        status,
        timestamp,
        progress,
      ];
}
