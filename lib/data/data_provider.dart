import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:breakq/utils/console.dart';

/// Provides a generic mechanism for loading model data from JSON files
/// (API simulation).
class DataProvider {
  const DataProvider();

  Future<List<dynamic>> get(uri) async {
    try {
      final rawData = await http.get(uri);
      if (rawData.statusCode >= 200 && rawData.statusCode < 300) {
        return rawData.body.isNotEmpty
            ? jsonDecode(rawData.body) as List<dynamic>
            : [];
      }
    } catch (_) {
      Console.log('DataProvider::get', _.toString(), error: _);
      return [];
    }
    return [];
  }

  Future<Map<String, dynamic>> getAsMap(uri) async {
    try {
      final rawData = await http.get(uri);
      if (rawData.statusCode >= 200 && rawData.statusCode < 300) {
        return rawData.body.isNotEmpty
            ? jsonDecode(rawData.body) as Map<String, dynamic>
            : {};
      }
    } catch (_) {
      Console.log('DataProvider::get', _.toString(), error: _);
      return {};
    }
    return {};
  }

  Future<bool> delete(uri) async {
    try {
      final rawData = await http.delete(uri);
      if (rawData.statusCode >= 200 && rawData.statusCode < 300) {
        return rawData.body.isNotEmpty
            ? jsonDecode(rawData.body) as bool
            : false;
      }
    } catch (_) {
      Console.log('DataProvider::get', _.toString(), error: _);
      return false;
    }
    return false;
  }

  Future<Map<String, dynamic>> post(uri, Map<String, dynamic> json) async {
    try {
      final rawData = await http.post(uri,
          body: jsonEncode(json),
          headers: {'Content-Type': 'application/json'});
      if (rawData.statusCode >= 200 && rawData.statusCode < 300) {
        return rawData.body.isNotEmpty
            ? jsonDecode(rawData.body) as Map<String, dynamic>
            : {};
      }
    } catch (_) {
      Console.log('DataProvider::get', _.toString(), error: _);
      return {};
    }
    return {};
  }

  Future<String> postByString(uri, Map<String, dynamic> json) async {
    try {
      final rawData = await http.post(uri,
          body: jsonEncode(json),
          headers: {'Content-Type': 'application/json'});
      if (rawData.statusCode >= 200 && rawData.statusCode < 300) {
        return rawData.body;
      }
    } catch (_) {
      Console.log('DataProvider::get', _.toString(), error: _);
      return "";
    }
    return "";
  }
}
