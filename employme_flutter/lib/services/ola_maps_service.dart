import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service for location search and reverse geocoding.
/// Uses Nominatim (OpenStreetMap) for reliable, free geocoding
/// that works on all platforms including Windows Desktop.
class OlaMapsService {
  static const String _nominatimBase = 'https://nominatim.openstreetmap.org';

  /// Fetches autocomplete / search results from Nominatim.
  /// Returns results in a format compatible with the existing UI code.
  static Future<List<Map<String, dynamic>>> getAutocomplete(String input) async {
    if (input.trim().isEmpty) return [];

    try {
      final uri = Uri.parse(
        '$_nominatimBase/search?q=${Uri.encodeComponent(input)}'
        '&format=json&addressdetails=1&limit=8'
        '&countrycodes=in' // Bias towards India
      );
      final response = await http.get(uri, headers: {
        'User-Agent': 'EmployeMe-Flutter-App/1.0',
        'Accept-Language': 'en',
      });

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map<Map<String, dynamic>>((item) {
          final addr = item['address'] ?? {};
          final mainText = addr['suburb'] ?? addr['neighbourhood'] ?? addr['village'] ?? addr['city'] ?? item['name'] ?? '';
          final secondaryParts = <String>[];
          if (addr['city'] != null && addr['city'] != mainText) secondaryParts.add(addr['city']);
          if (addr['state_district'] != null) secondaryParts.add(addr['state_district']);
          if (addr['state'] != null) secondaryParts.add(addr['state']);
          if (addr['postcode'] != null) secondaryParts.add(addr['postcode']);
          final secondaryText = secondaryParts.join(', ');

          return {
            'description': item['display_name'] ?? '',
            'structured_formatting': {
              'main_text': mainText,
              'secondary_text': secondaryText,
            },
            'lat': item['lat'],
            'lon': item['lon'],
          };
        }).toList();
      } else {
        print('Nominatim Search Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Nominatim Search Exception: $e');
    }
    return [];
  }

  /// Reverse geocodes coordinates into a human-readable address.
  static Future<Map<String, dynamic>?> reverseGeocode(double lat, double lng) async {
    try {
      final uri = Uri.parse(
        '$_nominatimBase/reverse?lat=${lat.toStringAsFixed(6)}'
        '&lon=${lng.toStringAsFixed(6)}'
        '&format=json&addressdetails=1&zoom=18'
      );
      final response = await http.get(uri, headers: {
        'User-Agent': 'EmployeMe-Flutter-App/1.0',
        'Accept-Language': 'en',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final addr = data['address'] ?? {};

        // Build a clean, human-readable name and formatted address
        final name = addr['road'] ?? addr['suburb'] ?? addr['neighbourhood'] ?? addr['village'] ?? data['name'] ?? 'Selected Location';
        
        final parts = <String>[];
        if (addr['suburb'] != null) parts.add(addr['suburb']);
        if (addr['city'] != null) parts.add(addr['city']);
        if (addr['state_district'] != null) parts.add(addr['state_district']);
        if (addr['state'] != null) parts.add(addr['state']);
        if (addr['postcode'] != null) parts.add(addr['postcode']);
        final formattedAddress = parts.join(', ');

        return {
          'name': name,
          'formatted_address': formattedAddress,
          'display_name': data['display_name'],
        };
      } else {
        print('Nominatim Reverse Geocode Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Nominatim Reverse Geocode Exception: $e');
    }
    return null;
  }
}
