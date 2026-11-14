class ShowModel {
  final int id;
  final String name;
  final String imageUrl;
  final String rating;
  final List<String> genres;
  final String summary;

  ShowModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.genres,
    required this.summary,
  });

  static String _cleanHtml(String? htmlText) {
    if (htmlText == null || htmlText.isEmpty) {
      return 'Tidak ada deskripsi tersedia.';
    }
    final clean = htmlText
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&apos;', "'")
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .trim();
    return clean.isEmpty ? 'Tidak ada deskripsi tersedia.' : clean;
  }

  factory ShowModel.fromJson(Map<String, dynamic> json) {
    return ShowModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Tanpa Judul',
      imageUrl: json['image'] != null
          ? (json['image']['original'] ?? json['image']['medium'] ?? '')
          : '',
      rating: json['rating'] != null && json['rating']['average'] != null
          ? json['rating']['average'].toString()
          : '-',
      genres: json['genres'] != null
          ? List<String>.from(json['genres'].map((g) => g.toString()))
          : <String>[],
      summary: _cleanHtml(json['summary']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'rating': rating,
      'genres': genres,
      'summary': summary,
    };
  }

  factory ShowModel.fromMap(Map<dynamic, dynamic> map) {
    return ShowModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? 'Tanpa Judul',
      imageUrl: map['imageUrl'] ?? '',
      rating: map['rating']?.toString() ?? '-',
      genres: map['genres'] != null
          ? List<String>.from(map['genres'])
          : <String>[],
      summary: map['summary'] ?? 'Tidak ada deskripsi tersedia.',
    );
  }
}
