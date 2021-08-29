import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:breakq/utils/console.dart';

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

  Future<String> getAsString(uri) async {
    try {
      final rawData = await http.get(uri);
      if (rawData.statusCode >= 200 && rawData.statusCode < 300) {
        return rawData.body;
      }
    } catch (_) {
      Console.log('DataProvider::get', _.toString(), error: _);
      return "";
    }
    return "";
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

  /// Simulation by getting asset data:
  ///
  Future<List<dynamic>> getAsset(String file) async {
    String content = '';

    try {
      content = await rootBundle.loadString('assets/data/$file.json');
      print('Loading asset : assets/data/$file.json');
    } catch (_) {
      Console.log('DataProvider::get', _.toString(), error: _);
    }

    return jsonDecode(content) as List<dynamic>;
  }
}
