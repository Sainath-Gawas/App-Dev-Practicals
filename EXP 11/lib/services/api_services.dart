import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String _historyBaseUrl = 'https://history.muffinlabs.com/date';

  // Fetch historical data for given month/day
  static Future<Map<String, dynamic>> fetchHistory(
      {int? month, int? day}) async {
    String url = _historyBaseUrl;
    if (month != null && day != null) {
      url = '$_historyBaseUrl/$month/$day';
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load history data');
    }
  }

  // Filter for Indian-related events
  static List<dynamic> filterIndianEvents(List<dynamic> events) {
    final keywords = [
      'India',
      'Indian',
      'Delhi',
      'Mumbai',
      'Kolkata',
      'Gandhi',
      'Nehru',
      'Ambedkar',
      'Raj',
      'Hindustan',
      'Mangalyaan'
    ];
    return events.where((e) {
      final text = e['text']?.toString().toLowerCase() ?? '';
      return keywords.any((kw) => text.contains(kw.toLowerCase()));
    }).toList();
  }

  // Fetch Wikipedia summary + image for a query
  static Future<Map<String, String>> fetchWikiSummary(String query) async {
    final encoded = Uri.encodeComponent(query);
    final url = 'https://en.wikipedia.org/api/rest_v1/page/summary/$encoded';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final extract = data['extract'] ?? '';
      final image =
          data['thumbnail'] != null ? data['thumbnail']['source'] : '';
      return {'extract': extract, 'image': image};
    } else {
      return {'extract': '', 'image': ''};
    }
  }
}
