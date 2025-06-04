import 'package:mongo_dart/mongo_dart.dart';

class MongoService {
  static Db? _db;
  static const String _connectionString = 'mongodb://localhost:27017/reservas';
  static const String _collectionName = 'reservas';

  static Future<void> connect() async {
    try {
      _db = await Db.create(_connectionString);
      await _db!.open();
      print('Connected to MongoDB successfully!');
    } catch (e) {
      print('Error connecting to MongoDB: $e');
      rethrow;
    }
  }

  static Future<void> disconnect() async {
    if (_db != null) {
      await _db!.close();
      print('Disconnected from MongoDB');
    }
  }

  static Future<void> insertData(Map<String, dynamic> data) async {
    try {
      final collection = _db!.collection(_collectionName);
      await collection.insert(data);
      print('Data inserted successfully');
    } catch (e) {
      print('Error inserting data: $e');
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> queryData(Map<String, dynamic> query) async {
    try {
      final collection = _db!.collection(_collectionName);
      final results = await collection.find(query).toList();
      return results;
    } catch (e) {
      print('Error querying data: $e');
      rethrow;
    }
  }

  static Future<void> updateData(Map<String, dynamic> query, Map<String, dynamic> update) async {
    try {
      final collection = _db!.collection(_collectionName);
      await collection.update(query, update);
      print('Data updated successfully');
    } catch (e) {
      print('Error updating data: $e');
      rethrow;
    }
  }

  static Future<void> deleteData(Map<String, dynamic> query) async {
    try {
      final collection = _db!.collection(_collectionName);
      await collection.remove(query);
      print('Data deleted successfully');
    } catch (e) {
      print('Error deleting data: $e');
      rethrow;
    }
  }
} 