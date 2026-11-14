import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/show_model.dart';

class ApiService {
  static const String baseUrl = 'https://api.tvmaze.com';

  static Future<List<ShowModel>> fetchShows() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/shows'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => ShowModel.fromJson(item)).toList();
      } else {
        throw Exception('Gagal memuat data shows: Status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat data: $e');
    }
  }

  static Future<ShowModel> fetchShowDetail(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/shows/$id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return ShowModel.fromJson(jsonData);
      } else {
        throw Exception('Gagal memuat detail show: Status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat detail show: $e');
    }
  }
}
