import 'data.dart';
import 'models.dart';
import 'catalogue.dart';
import 'shelf_state.dart';

void main() {
  final books = rawBooks.map(Book.fromJson).toList();

  final library = Library(books);

  print(library.titles);
print(library.booksAfter2010);
print(library.averagePages);

print(describe(Empty()));
print(describe(Ready(books)));
print(describe(Broken('Test error')));

final stats = statsOf(books);
print(stats);
}