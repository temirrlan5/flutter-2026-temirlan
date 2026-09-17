import 'models.dart';

class Library {
  final List<LibraryItem> items;
  late final DateTime openedAt;

  String? _cachedReport;

  Library(this.items);

  void open() {
    openedAt = DateTime.now();
  }

  void add(LibraryItem item) {
    items.add(item);
  }

  Book? findByTitle(String title) {
    for (final item in items) {
      if (item is Book && item.title == title) {
        return item;
      }
    }
    return null;
  }

  String countryOf(String title) {
    return findByTitle(title)?.author.country ?? 'unknown';
  }

  String report() {
    return _cachedReport ??= 'Library contains ${items.length} items';
}

List<String> get titles => items.map((item) => item.title).toList();

List<Book> get booksAfter2010 => items
    .where((item) => item is Book && item.year > 2010)
    .map((item) => item as Book)
    .toList();

double get averagePages => items
    .whereType<Book>()
    .fold<int>(0, (sum, book) => sum + book.pages) /
    (items.whereType<Book>().length);

    Map<String, int> get booksByAuthor => items
    .whereType<Book>()
    .fold<Map<String, int>>(
      {},
      (map, book) {
        map[book.author.name] = (map[book.author.name] ?? 0) + 1;
        return map;
      },
    ); 

Set<String> get authorNames => 
  items
    .whereType<Book>()
    .map((book) => book.author.name)
    .toSet();

Set<Genre> get genres =>
  items
    .whereType<Book>()
    .map((book) => book.genre)
    .toSet();

List<String> get displayList => [
  'CATALOGUE',
  ...items.whereType<Book>().map((book) => '${book.title} (${book.year})'),
  ...items.whereType<Book>().map((book) => book.author.name),
  if (items.whereType<Book>().any((book) => book.pages == 0))
    '(incomplete data)',
];
}