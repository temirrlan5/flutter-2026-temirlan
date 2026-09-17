import 'models.dart';

sealed class ShelfState {}

class Empty extends ShelfState {}

class Ready extends ShelfState {
  final List<Book> books;

  Ready(this.books);
}

class Broken extends ShelfState {
  final String message;

  Broken(this.message);
}

String describe(ShelfState state) => switch (state) {
  Empty() => 'Shelf is empty',
  Ready(:final books) => 'Shelf has ${books.length} books',
  Broken(:final message) => 'Shelf is broken: $message',
};

({int count, double avgPages}) statsOf(List<Book> books) {
  final count = books.length;

  final totalPages = books.fold<int>(
    0,
    (sum, book) => sum + book.pages,
  );

  final avgPages = count == 0 ? 0.0 : totalPages / count;

  return (
    count: count,
    avgPages: avgPages,
  );
}