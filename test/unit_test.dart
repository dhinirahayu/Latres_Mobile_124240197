import 'package:flutter_test/flutter_test.dart';
import 'package:latres_124240197/models/show_model.dart';

void main() {
  group('ShowModel Test', () {
    test('ShowModel parsing from JSON with HTML summary', () {
      final json = {
        'id': 1,
        'name': 'Under the Dome',
        'image': {
          'medium': 'https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg',
          'original': 'https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg'
        },
        'rating': {'average': 6.5},
        'genres': ['Drama', 'Science-Fiction', 'Thriller'],
        'summary': '<p><b>Under the Dome</b> is a great show &amp; series.</p>'
      };

      final show = ShowModel.fromJson(json);

      expect(show.id, 1);
      expect(show.name, 'Under the Dome');
      expect(show.rating, '6.5');
      expect(show.genres, ['Drama', 'Science-Fiction', 'Thriller']);
      expect(show.summary, 'Under the Dome is a great show & series.');
    });

    test('ShowModel Map conversion for Hive', () {
      final show = ShowModel(
        id: 10,
        name: 'The Flash',
        imageUrl: 'https://example.com/flash.jpg',
        rating: '7.8',
        genres: ['Action', 'Drama'],
        summary: 'Barry Allen is The Flash.',
      );

      final map = show.toMap();
      final fromHive = ShowModel.fromMap(map);

      expect(fromHive.id, 10);
      expect(fromHive.name, 'The Flash');
      expect(fromHive.rating, '7.8');
      expect(fromHive.genres, ['Action', 'Drama']);
      expect(fromHive.summary, 'Barry Allen is The Flash.');
    });
  });
}
