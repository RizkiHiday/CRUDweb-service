import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item.dart';

class ApiService {
  final String baseUrl = 'https://67288f80270bd0b9755636de.mockapi.io/v1/users';

  // Fungsi untuk mengambil semua item
  Future<List<Item>> getItems() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Item.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  // Fungsi untuk membuat item baru
  Future<Item> createItem(Item item) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    print('Request Body: ${jsonEncode(item.toJson())}'); 
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      return Item.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to create item: ${response.body}');
      throw Exception('Failed to create item');
    }
  }

  // Fungsi untuk memperbarui item yang sudah ada
  Future<void> updateItem(Item item) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${item.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    print('Request Body for Update: ${jsonEncode(item.toJson())}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      print('Failed to update item: ${response.body}');
      throw Exception('Failed to update item');
    }
  }

  // Fungsi untuk menghapus item berdasarkan id
  Future<void> deleteItem(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    print('Response status for Delete: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      print('Failed to delete item: ${response.body}');
      throw Exception('Failed to delete item');
    }
  }
}
