import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/blog.dart';

class BlogProvider extends ChangeNotifier {
  final String apiUrl = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  List<Blog> blogs = [];

  Future<void> fetchBlogs() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'x-hasura-admin-secret': adminSecret},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('blogs') && data['blogs'] is List) {
          final List<dynamic> blogList = data['blogs'];
          blogs = blogList
              .map((item) => Blog(
                    title: item['title'],
                    imageUrl: item['image_url'],
                  ))
              .toList();

          notifyListeners();
        } else {
          throw Exception('Invalid API response format');
        }
      } else {
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void toggleFavoriteStatus(Blog blog) {
    final index = blogs.indexOf(blog);
    if (index != -1) {
      blogs[index] = Blog(
        title: blog.title,
        imageUrl: blog.imageUrl,
        isFavorite: !blog.isFavorite,
      );
      notifyListeners();
    }
  }
}