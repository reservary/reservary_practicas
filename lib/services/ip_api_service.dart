import 'dart:convert';
import 'package:http/http.dart' as http;

class IpApiService {
  static const String _baseUrl = 'http://ip-api.com/json';

  Future<Map<String, dynamic>> getIpInfo() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load IP information');
      }
    } catch (e) {
      throw Exception('Error connecting to IP API: $e');
    }
  }

  // Método específico para obtener la ubicación
  Future<Map<String, dynamic>> getLocation() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?fields=country,regionName,city,lat,lon,countryCode'));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load location information');
      }
    } catch (e) {
      throw Exception('Error connecting to IP API: $e');
    }
  }

  Future<Map<String, dynamic>> getIpInfoForAddress(String ipAddress) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$ipAddress?fields=country,regionName,city,lat,lon,countryCode'));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load IP information for $ipAddress');
      }
    } catch (e) {
      throw Exception('Error connecting to IP API: $e');
    }
  }
} 